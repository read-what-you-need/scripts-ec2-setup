#!/bin/bash

api_list=("pdf-to-text" "semantic-search-handler" "e2eqg")
api_status_update_webhook=(https://hc-ping.com/7f85932c-54fa-4229-8d2a-f4d0d84135c9 https://hc-ping.com/033d8bdc-ba70-4868-b61c-bf2bb1acf8d6 https://hc-ping.com/e79cf8ce-bd5c-41c8-99db-2ba6fc8d0001)


for i in "${!api_list[@]}";
        do
                echo "checking ${api_list[i]} api";

                if cortex get "${api_list[i]}" | grep -q live
                        then

                           echo "OK";
                           api_status=$(cortex get ${api_list[i]} | grep live)
                           echo "$api_status"
                           curl -fsS -m 5 --retry 5 --data-raw "$api_status" "${api_status_update_webhook[i]}"

                        else
                           echo "NOT OK";
                           api_status=$(cortex get ${api_list[i]} | head -n 3 | tail -n 1)
                           echo "$api_status"
                           curl -fsS -m 5 --retry 5 --data-raw "$api_status" "${api_status_update_webhook[i]}/fail"
                fi
                printf "\n\n"

done
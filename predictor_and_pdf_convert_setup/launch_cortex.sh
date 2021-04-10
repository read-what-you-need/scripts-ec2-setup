#!/bin/bash
cd pdf-to-text
cortex delete pdf-to-text
cortex deploy
cd ..
cd semantic-search-handler
cortex delete semantic-search-handler
cortex deploy
cd ..
cd e2e-qg
cortex delete e2eqg
cortex deploy
cd ~
#cortex get --watch
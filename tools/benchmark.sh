#!/bin/bash

MODEL_TYPE="llama"
MODEL_DIR="xxx/llama_7b_ppl"
MODEL_PARAM_PATH="xxx/llama_7b_ppl/params.json"
TENSOR_PARALLEL_SIZE=1
TOP_P=0.0
TOP_K=1
TEMPERATURE=1.0
WARMUP_LOOPS=2
BENCHMARK_LOOPS=2
DATA_FILE_BASE="${HOME}/ppl.nn.llm/tools"

INPUT_LEN=8
GENERATION_LEN=256
BATCH_SIZE_LIST=(1 2 4 8 16 32 64 128 256)

QUANT_METHOD="online_i8i8"

BENCHMARK_LLM="xxx/ppl.nn.llm/pplnn-build/tools/benchmark_llama"

for BATCH_SIZE in ${BATCH_SIZE_LIST[@]}; do
    $BENCHMARK_LLM \
        --model-type $MODEL_TYPE \
        --model-dir $MODEL_DIR \
        --model-param-path $MODEL_PARAM_PATH \
        --tensor-parallel-size $TENSOR_PARALLEL_SIZE \
        --top-p $TOP_P \
        --top-k $TOP_K \
        --temperature $TEMPERATURE \
        --warmup-loops $WARMUP_LOOPS \
        --generation-len $GENERATION_LEN \
        --benchmark-loops $BENCHMARK_LOOPS \
        --input-len $INPUT_LEN \
        --batch-size $BATCH_SIZE \
        --quant-method $QUANT_METHOD
done

# for benchmark and result verify

# for BATCH_SIZE in ${BATCH_SIZE_LIST[@]}; do
#     INPUT_FILE="${DATA_FILE_BASE}/tokens_input_${INPUT_LEN}"
#     OUTPUT_FILE="${DATA_FILE_BASE}/tokens_output_${INPUT_LEN}_${GENERATION_LEN}"
#     $BENCHMARK_LLM \
#         --model-type $MODEL_TYPE \
#         --model-dir $MODEL_DIR \
#         --model-param-path $MODEL_PARAM_PATH \
#         --tensor-parallel-size $TENSOR_PARALLEL_SIZE \
#         --top-p $TOP_P \
#         --top-k $TOP_K \
#         --temperature $TEMPERATURE \
#         --warmup-loops $WARMUP_LOOPS \
#         --generation-len $GENERATION_LEN \
#         --benchmark-loops $BENCHMARK_LOOPS \
#         --input-file $INPUT_FILE \
#         --output-file $OUTPUT_FILE \
#         --batch-size $BATCH_SIZE \
#         --quant-method $QUANT_METHOD
# done

# input token: 1, 306, 4658, 278, 6593, 310, 2834, 338
# output token ground truth: 304, 1284, 596, 19797, 29889, 450, 6437, 310
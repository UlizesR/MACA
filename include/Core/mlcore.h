#ifndef ML_CORE_H
#define ML_CORE_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>

// Macro to define the visibility of a symbol in the shared library
#define MLAPI __attribute__((visibility("default")))

// Core

typedef struct MLWindow MLWindow;

typedef struct
{
    MLWindow *m_window;         // Application main window
} ML_INTERNAL_STATE;

#ifdef __cplusplus
}
#endif

#endif // ML_CORE_H

#ifndef ML_WINDOW_H
#define ML_WINDOW_H


#include "mlcore.h"

#ifdef __cplusplus
extern "C" {
#endif

MLAPI MLWindow *MLWindowCreate(const char *title, const uint16_t width, const uint16_t height);

MLAPI void MLWindowClose(MLWindow *window);

MLAPI bool MLWindowShouldClose(MLWindow *window);

MLAPI void MLWindowDestroy(MLWindow *window);

#ifdef __cplusplus
}
#endif // __cplusplus

#endif // ML_WINDOW_H

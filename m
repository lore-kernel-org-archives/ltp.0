From: Petr Vorel <petr.vorel@gmail.com>
Date: Sat,  2 Sep 2017 02:59:23 +0200
Subject: [LTP] [RFC PATCH 3/6] android: Add pty.h header
In-Reply-To: <20170902005926.15923-1-petr.vorel@gmail.com>
References: <20170902005926.15923-1-petr.vorel@gmail.com>
Message-ID: <20170902005926.15923-4-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Taken from Bionic, modified.

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
I needed to add #include "versioning.h".
I was tempted to use check
#if defined(__ANDROID_API__) && __ANDROID_API__ >= 23
instead of macro __INTRODUCED_IN(X) which causes warnings, but smaller delta won.
---
 include/android/pty.h        | 46 ++++++++++++++++++++++++++++++++++++++++++++
 include/android/versioning.h | 32 ++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)
 create mode 100644 include/android/pty.h
 create mode 100644 include/android/versioning.h

diff --git a/include/android/pty.h b/include/android/pty.h
new file mode 100644
index 000000000..dbcaad225
--- /dev/null
+++ b/include/android/pty.h
@@ -0,0 +1,46 @@
+/*
+ * Copyright (C) 2014 The Android Open Source Project
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ *  * Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ *  * Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in
+ *    the documentation and/or other materials provided with the
+ *    distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
+ * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
+ * COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
+ * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
+ * OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
+ * AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
+ * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
+ * OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ */
+
+#ifndef _PTY_H
+#define _PTY_H
+
+#include <sys/cdefs.h>
+
+#include <termios.h>
+#include <sys/ioctl.h>
+
+#include "versioning.h"
+
+__BEGIN_DECLS
+
+int openpty(int* __master_fd, int* __slave_fd, char* __slave_name, const struct termios* __termios_ptr, const struct winsize* __winsize_ptr) __INTRODUCED_IN(23);
+int forkpty(int* __master_fd, char* __slave_name, const struct termios* __termios_ptr, const struct winsize* __winsize_ptr) __INTRODUCED_IN(23);
+
+__END_DECLS
+
+#endif
diff --git a/include/android/versioning.h b/include/android/versioning.h
new file mode 100644
index 000000000..4e1a1854c
--- /dev/null
+++ b/include/android/versioning.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright (C) 2016 The Android Open Source Project
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ */
+
+#ifndef ANDROID_VERSIONING_H
+#define ANDROID_VERSIONING_H
+
+#define __INTRODUCED_IN(api_level) __attribute__((annotate("introduced_in=" #api_level)))
+#define __INTRODUCED_IN_FUTURE __attribute__((annotate("introduced_in_future")))
+#define __DEPRECATED_IN(api_level) __attribute__((annotate("deprecated_in=" #api_level)))
+#define __REMOVED_IN(api_level) __attribute__((annotate("obsoleted_in=" #api_level)))
+#define __INTRODUCED_IN_32(api_level) __attribute__((annotate("introduced_in_32=" #api_level)))
+#define __INTRODUCED_IN_64(api_level) __attribute__((annotate("introduced_in_64=" #api_level)))
+#define __INTRODUCED_IN_ARM(api_level) __attribute__((annotate("introduced_in_arm=" #api_level)))
+#define __INTRODUCED_IN_X86(api_level) __attribute__((annotate("introduced_in_x86=" #api_level)))
+#define __INTRODUCED_IN_MIPS(api_level) __attribute__((annotate("introduced_in_mips=" #api_level)))
+
+#define __VERSIONER_NO_GUARD __attribute__((annotate("versioner_no_guard")))
+
+#endif /* ANDROID_VERSIONING_H */
-- 
2.14.0


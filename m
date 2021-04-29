From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 29 Apr 2021 16:05:06 +0100
Subject: [LTP] [PATCH v2 1/5] lapi/bpf: Add /=, %= and BPF_MAXINSNS
In-Reply-To: <20210429150510.21585-1-rpalethorpe@suse.com>
References: <20210429150510.21585-1-rpalethorpe@suse.com>
Message-ID: <20210429150510.21585-2-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add div and mod instructions and the max program size.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/lapi/bpf.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/lapi/bpf.h b/include/lapi/bpf.h
index f27a92146..0a25edb73 100644
--- a/include/lapi/bpf.h
+++ b/include/lapi/bpf.h
@@ -37,8 +37,10 @@
 #define BPF_OP(code)    ((code) & 0xf0)
 #define		BPF_ADD		0x00
 #define		BPF_SUB		0x10
+#define		BPF_DIV		0x30
 #define		BPF_LSH		0x60
 #define		BPF_RSH		0x70
+#define		BPF_MOD		0x90
 
 #define		BPF_JEQ		0x10
 
@@ -46,6 +48,10 @@
 #define		BPF_K		0x00
 #define		BPF_X		0x08
 
+#ifndef BPF_MAXINSNS
+#define BPF_MAXINSNS 4096
+#endif
+
 #define BPF_ALU64	0x07	/* alu mode in double word width */
 #define BPF_MOV		0xb0	/* mov reg to reg */
 #define BPF_CALL	0x80	/* function call */
-- 
2.31.1


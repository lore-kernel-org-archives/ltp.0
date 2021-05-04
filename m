From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  4 May 2021 14:57:29 +0200
Subject: [LTP] [PATCH v3 1/1] docparse: Escape backslash,
 tab and double quote in JSON
Message-ID: <20210504125729.18781-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Cyril Hrubis <chrubis@suse.cz>

NOTE: quoting new line require to transform .options from array to
array of arrays.

Tested-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

changes v2-v3:
* remove *not* quoting new line (asked by Cyril

Patch is now exactly the same Cyril suggested on ML.
Changing .options is my TODO.

Kind regards,
Petr

 docparse/data_storage.h | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/docparse/data_storage.h b/docparse/data_storage.h
index ef420c08f..24381334b 100644
--- a/docparse/data_storage.h
+++ b/docparse/data_storage.h
@@ -256,6 +256,35 @@ static inline void data_fprintf(FILE *f, unsigned int padd, const char *fmt, ...
 	va_end(va);
 }
 
+
+static inline void data_fprintf_esc(FILE *f, unsigned int padd, const char *str)
+{
+	while (padd-- > 0)
+		fputc(' ', f);
+
+	fputc('"', f);
+
+	while (*str) {
+		switch (*str) {
+		case '\\':
+			fputs("\\\\", f);
+			break;
+		case '"':
+			fputs("\\\"", f);
+			break;
+		case '\t':
+			fputs("\\t", f);
+			break;
+		default:
+			putc(*str, f);
+			break;
+		}
+		str++;
+	}
+
+	fputc('"', f);
+}
+
 static inline void data_to_json_(struct data_node *self, FILE *f, unsigned int padd, int do_padd)
 {
 	unsigned int i;
@@ -263,7 +292,7 @@ static inline void data_to_json_(struct data_node *self, FILE *f, unsigned int p
 	switch (self->type) {
 	case DATA_STRING:
 		padd = do_padd ? padd : 0;
-		data_fprintf(f, padd, "\"%s\"", self->string.val);
+		data_fprintf_esc(f, padd, self->string.val);
 	break;
 	case DATA_HASH:
 		for (i = 0; i < self->hash.elems_used; i++) {
-- 
2.31.1


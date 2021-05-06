From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  6 May 2021 15:27:45 +0200
Subject: [LTP] [PATCH v4 1/1] docparse: Handle special characters in JSON
Message-ID: <20210506132745.16973-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* escape backslash (/) and double quote (")
  escaping backslash effectively escapes other C escaped strings (\t,
  \n, ...), which we sometimes want (in the comment) but sometimes not
  (in .option we want to have them interpreted)
* replace tab with 8x space
* skip and TWARN invalid chars (< 0x20, i.e. anything before space)
  defined by RFC 8259 (https://tools.ietf.org/html/rfc8259#page-9)

NOTE: atm fix is required only for ", but tab was problematic in the past.

TODO: This is just a "hot fix" solution before release. Proper solution
would be to check if chars needed to be escaped (", \, /) aren't already
escaped.

Also for correct decision whether \n, \t should be escaped or interpreted
we should decide in the parser which has the context. C string should be
probably interpreted (thus nothing needed to be done as it escapes in
a compatible way with JSON), but comments probably should display \n, \t
thus add extra \.

Fixes: c39b29f0a ("bpf: Check truncation on 32bit div/mod by zero")

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Co-developed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 docparse/data_storage.h | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/docparse/data_storage.h b/docparse/data_storage.h
index ef420c08f..9f36dd6f0 100644
--- a/docparse/data_storage.h
+++ b/docparse/data_storage.h
@@ -256,6 +256,40 @@ static inline void data_fprintf(FILE *f, unsigned int padd, const char *fmt, ...
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
+			fputs("        ", f);
+			break;
+		default:
+			/* RFC 8259 specify  chars before 0x20 as invalid */
+			if (*str >= 0x20)
+				putc(*str, f);
+			else
+				fprintf(stderr, "%s:%d %s(): invalid character for JSON: %x\n",
+						__FILE__, __LINE__, __func__, *str);
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
@@ -263,7 +297,7 @@ static inline void data_to_json_(struct data_node *self, FILE *f, unsigned int p
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


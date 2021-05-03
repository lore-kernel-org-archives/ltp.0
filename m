From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  3 May 2021 15:30:25 +0200
Subject: [LTP] [PATCH v2 1/1] docparse: Escape backslash,
 tab and double quote in JSON
Message-ID: <20210503133025.2557-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Cyril Hrubis <chrubis@suse.cz>

Avoid quoting new line as it's usually expected formatting,
e.g. in .options field.

Tested-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
[ pvorel: keep \n ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

I kept \n, it's usually expected formatting in .options:

* \n kept:
p: p_opt -p port Rhost port (mandatory)

r: r_opt -r x Rhost IP (mandatory)

-g, -r IP parameter can contain more IP, separated by CHR2STR ( IP_ADDR_DELIM )

* \n replaced:
p: p_opt -p port Rhost port (mandatory)

r: r_opt -r x Rhost IP (mandatory)\n\n-g, -r IP parameter can contain more IP, separated by CHR2STR ( IP_ADDR_DELIM )

Kind regards,
Petr

 docparse/data_storage.h | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/docparse/data_storage.h b/docparse/data_storage.h
index ef420c08f..5afeba42c 100644
--- a/docparse/data_storage.h
+++ b/docparse/data_storage.h
@@ -256,6 +256,39 @@ static inline void data_fprintf(FILE *f, unsigned int padd, const char *fmt, ...
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
+			/* keep \n, it's usually expected formatting in .options */
+			if (*(str+1) == 'n')
+				putc(*str, f);
+			else
+				fputs("\\\\", f);
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
@@ -263,7 +296,7 @@ static inline void data_to_json_(struct data_node *self, FILE *f, unsigned int p
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


From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  3 May 2021 10:57:32 +0200
Subject: [LTP] [PATCH 1/1] docparse: Escape backslash,
 tab and double quote in JSON
Message-ID: <20210503085732.9637-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

not sure if I should escape more, e.g.:
\b  Backspace (ascii code 08)
\f  Form feed (ascii code 0C)
\n  New line
\r  Carriage return

Tested on Richard's BPF patchset [1], which got affected on " + previous
problems on CAN tests, which contained \t in testcases/network/can/filter-tests/can_filter.c
(i.e. with reverted 1cdf8ce8b).

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/list/?series=240772&state=*
[2] https://patchwork.ozlabs.org/project/ltp/patch/20210426120107.6632-2-rpalethorpe@suse.com/

 docparse/data_storage.h | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/docparse/data_storage.h b/docparse/data_storage.h
index ef420c08f..08cdc009d 100644
--- a/docparse/data_storage.h
+++ b/docparse/data_storage.h
@@ -256,14 +256,46 @@ static inline void data_fprintf(FILE *f, unsigned int padd, const char *fmt, ...
 	va_end(va);
 }
 
-static inline void data_to_json_(struct data_node *self, FILE *f, unsigned int padd, int do_padd)
+static inline void json_escape_(char str[], char search, char replace[])
+{
+	char *tmp;
+	char *p = str;
+	size_t i, str_len, tmp_len, replace_len, shift;
+
+	while ((tmp = strchr(p, search))) {
+		str_len = strlen(str);
+		tmp_len = strlen(tmp);
+		replace_len = strlen(replace);
+		shift = str_len - tmp_len;
+
+		memmove(str + shift + replace_len - 1, str + shift, tmp_len);
+
+		for (i = 0; i < replace_len; i++)
+			str[shift++] = replace[i];
+
+		str[str_len + replace_len - 1] = '\0';
+		p = tmp + replace_len;
+	}
+}
+
+static inline const char *json_escape(char *input)
+{
+	json_escape_(input, '\\', "\\\\");
+	json_escape_(input, '"', "\\\"");
+	json_escape_(input, '\t', "\\t");
+
+	return input;
+}
+
+static inline void data_to_json_(struct data_node *self, FILE *f, unsigned int
+				 padd, int do_padd)
 {
 	unsigned int i;
 
 	switch (self->type) {
 	case DATA_STRING:
 		padd = do_padd ? padd : 0;
-		data_fprintf(f, padd, "\"%s\"", self->string.val);
+		data_fprintf(f, padd, "\"%s\"", json_escape((self->string.val)));
 	break;
 	case DATA_HASH:
 		for (i = 0; i < self->hash.elems_used; i++) {
-- 
2.31.1


From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 1 Apr 2020 13:42:50 +0200
Subject: [LTP] LTP compilation broken with -fno-common
In-Reply-To: <20200401105055.GC23773@yuki.lan>
References: <20200401083228.GA18685@dell5510> <20200401093934.GA23773@yuki.lan>
 <e9ea8c2a-7c00-26a7-fb1a-0db9ae093620@suse.cz>
 <20200401095822.GB23773@yuki.lan>
 <aa695e74-2aed-2b9e-c0c0-7626dfc0a7e1@suse.cz>
 <20200401105055.GC23773@yuki.lan>
Message-ID: <fd62323e-3d29-884d-1a0c-bf1adc3e28c2@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 01. 04. 20 12:50, Cyril Hrubis wrote:
> Hi!
>>> The problem here is that gcc10 forbids variables in headers, moving it
>>> anywhere int the header wouldn't help.
>>
>> I don't think GCC cares about where exactly the variable came from. It's
>> only refusing to link multiple definitions of the same symbol. So if we
>> move the TCID definition into the TST_NO_DEFAULT_MAIN guard block, GCC
>> linker should stop complaining because the symbol name will become unique.
> 
> See:
> 
> https://gcc.gnu.org/gcc-10/porting_to.html
> 

This patch fixes the "multiple definition of `TCID'" error. But never
mind because we'll get the "undefined reference to `TCID'" error instead
from about 50 programs files that use the new library but define their
own main().

Reminder that "multiple definition of `TCID'" is a linker error. If
defining variables in .h files were really forbidden, it'd be a
preprocessor error instead.

diff --git a/include/tst_test.h b/include/tst_test.h
index 42c02b549..cc163ae51 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -308,6 +308,10 @@ char *tst_get_tmpdir(void);

 #ifndef TST_NO_DEFAULT_MAIN

+/*
+ * This is a hack to make the testcases link without defining TCID
+ */
+const char *TCID;
 static struct tst_test test;

 int main(int argc, char *argv[])
@@ -319,9 +323,7 @@ int main(int argc, char *argv[])

 #define TST_TEST_TCONF(message)                                 \
         static struct tst_test test = { .tconf_msg = message  } \
-/*
- * This is a hack to make the testcases link without defining TCID
- */
-const char *TCID;
+
+extern const char *TCID;

 #endif /* TST_TEST_H__ */


-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

From: Chunyu Hu <chuhu@redhat.com>
Date: Tue, 13 Jun 2017 07:47:44 -0400 (EDT)
Subject: [LTP] [PATCH] Make getrusage04 be able to loop more times
In-Reply-To: <20170612150423.GA32564@rei.lan>
References: <1496388495-30584-1-git-send-email-chuhu@redhat.com>
 <20170607151315.GA30168@rei.suse.de>
 <2050137840.17454791.1496994121958.JavaMail.zimbra@redhat.com>
 <20170612150423.GA32564@rei.lan>
Message-ID: <1622893199.18143718.1497354464220.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Chunyu Hu" <chuhu@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Monday, June 12, 2017 11:04:23 PM
> Subject: Re: [LTP] [PATCH] Make getrusage04 be able to loop more times
> 
> Hi!
> > Do we have? I think we need something like below, not clear
> > about if this can be done with function or macro ;).
> > 
> > timval_minus(tv1, tv2)
> > and
> > timeval_gt
> > timeval_lt
> > timeval_e
> 
> We only need to add tst_timeval_diff_us() into tst_timer.h then we can
> compare the resulting values in microsenconds. Which would mean adding
> tst_timeval_to_us() and tst_timeval_diff(), then adding the
> tst_timeval_diff_us() that combines these two.

This really sounds simpler than compare with timeval directly. But compare
with timeval directly would make it more difficult to overflow. 

> 
> It should be staturated difference though, i.e. the conversion from
> timeval to microseconds should return LONG_LONG_MAX in a case that the
> end result would overflow long long.

That makes sense. But how long would it overflow once? 

>>> print "%d" % 0xffffffffffffffff
18446744073709551615
>>> print 18446744073709551615 / 1000000
18446744073709
>>> print "%d" % 0xffffffff
4294967295
>>> print 4294967295 / 1000000
4294


> 
> As I said I can add these into the tst_timer.h, and also fix the
> timespec to us and ms conversions to be saturated.

OK. Thanks. I'll wait for your helpers before I submit a v2 for the test case.

In fact, I use the test case to reproduce an issue of getrusage on rhel-7.3
which needs about 60s.

getrusage04    0  TINFO  :  utime:6s       825358us; stime:38s       286683us
getrusage04    0  TINFO  :  utime:6s       825358us; stime:38s       287683us
getrusage04    0  TINFO  :  utime:6s       825358us; stime:38s       288683us
getrusage04    0  TINFO  :  utime:6s       825358us; stime:38s       288745us
getrusage04    0  TINFO  :  utime:6s       825362us; stime:38s       288763us
getrusage04    0  TINFO  :  utime:6s       825365us; stime:38s       290782us
getrusage04    1  TFAIL  :  getrusage04.c:195: stime increased > 2000us:


And I tried with comparing with timeval directly, I paste it here just hoping
it can provide a little idea.( just for fun) :)


diff --git a/testcases/kernel/syscalls/getrusage/getrusage04.c b/testcases/kernel/syscalls/getrusage/getrusage04.c
index a5b3f65..583b6ea 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage04.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage04.c
@@ -79,10 +79,65 @@ static void busyloop(long wait);
 static void setup(void);
 static void cleanup(void);
 
+#ifndef bool
+ #define bool int
+ #ifndef false
+  #define false 0
+ #endif
+ #ifndef true
+  #define true 1
+ #endif
+#endif
+
+static inline struct timeval timeval_minus(struct timeval t1, struct timeval t2)
+{
+        struct timeval result;
+        result.tv_sec = t1.tv_sec - t2.tv_sec;
+
+        result.tv_usec = t1.tv_usec >= t2.tv_usec ?
+                (t1.tv_usec - t2.tv_usec) :
+                result.tv_sec > 0 ?
+                (result.tv_sec--,t1.tv_usec + 1000000) - t2.tv_usec:
+                t1.tv_usec - t2.tv_usec;
+        return result;
+}
+
+static inline bool timeval_cmp_gt(struct timeval t1, struct timeval t2)
+{
+        return t1.tv_sec > t2.tv_sec ?
+                true : t1.tv_sec < t2.tv_sec ?
+                false : t1.tv_usec > t2.tv_usec;
+}
+
+struct timeval mk_timeval(long long sec, long long usec)
+{
+        struct timeval t = {0};
+        t.tv_sec = sec;
+        t.tv_sec += usec / 1000000;
+        t.tv_usec = usec % 1000000;
+        return t;
+}
+
+#define TIMEVAL_POSITIVE(tv) \
+({ \
+        int r;                \
+        r = (tv.tv_sec >= 0 && tv.tv_usec > 0); \
+        r; \
+})
+
+
+#define TIMEVAL_NON_NEGATIVE(tv) \
+({                                                        \
+        int r; \
+        r = (tv.tv_sec >= 0 && tv.tv_usec >= 0); \
+        r; \
+ })
+
 int main(int argc, char *argv[])
 {
         struct rusage usage;
-        unsigned long ulast, udelta, slast, sdelta;
+        struct timeval ulast, slast;
+        struct timeval udelta, sdelta;
         int i, lc;
         char msg_string[BUFSIZ];
 
@@ -104,28 +159,32 @@ int main(int argc, char *argv[])
                 tst_count = 0;
                 i = 0;
                 SAFE_GETRUSAGE(cleanup, RUSAGE_THREAD, &usage);
-                tst_resm(TINFO, "utime:%12luus; stime:%12luus",
-                         usage.ru_utime.tv_usec, usage.ru_stime.tv_usec);
-                ulast = usage.ru_utime.tv_usec;
-                slast = usage.ru_stime.tv_usec;
+                tst_resm(TINFO, "utime:%lus %12luus; stime:%lus %12luus",
+                         usage.ru_utime.tv_sec, usage.ru_utime.tv_usec,
+                                usage.ru_stime.tv_sec, usage.ru_stime.tv_usec);
+
+                ulast = usage.ru_utime;
+                slast = usage.ru_stime;
 
                 while (i < RECORD_MAX) {
                         SAFE_GETRUSAGE(cleanup, RUSAGE_THREAD, &usage);
-                        udelta = usage.ru_utime.tv_usec - ulast;
-                        sdelta = usage.ru_stime.tv_usec - slast;
-                        if (udelta > 0 || sdelta > 0) {
+                        udelta = timeval_minus(usage.ru_utime, ulast);
+                        sdelta = timeval_minus(usage.ru_stime, slast);
+                        if (TIMEVAL_POSITIVE(udelta) || TIMEVAL_POSITIVE(sdelta)) {
                                 i++;
-                                tst_resm(TINFO, "utime:%12luus; stime:%12luus",
-                                         usage.ru_utime.tv_usec,
-                                         usage.ru_stime.tv_usec);
-                                if (udelta > 1000 + (BIAS_MAX * factor_nr)) {
+                                tst_resm(TINFO, "utime:%lus %12luus; stime:%lus %12luus",
+                                        usage.ru_utime.tv_sec, usage.ru_utime.tv_usec,
+                                        usage.ru_stime.tv_sec, usage.ru_stime.tv_usec);
+                                if (timeval_cmp_gt(udelta,
+                                                        mk_timeval(0, 1000 + (BIAS_MAX * factor_nr)))) {
                                         sprintf(msg_string,
                                                 "utime increased > %ldus:",
                                                 1000 + BIAS_MAX * factor_nr);
                                         tst_brkm(TFAIL, cleanup, msg_string,
                                                  " delta = %luus", udelta);
                                 }
-                                if (sdelta > 1000 + (BIAS_MAX * factor_nr)) {
+                                if (timeval_cmp_gt(sdelta,
+                                                        mk_timeval(0, 1000 + (BIAS_MAX * factor_nr)))) {
                                         sprintf(msg_string,
                                                 "stime increased > %ldus:",
                                                 1000 + BIAS_MAX * factor_nr);
@@ -133,8 +192,8 @@ int main(int argc, char *argv[])
                                                  " delta = %luus", sdelta);
                                 }
                         }
-                        ulast = usage.ru_utime.tv_usec;
-                        slast = usage.ru_stime.tv_usec;
+                        ulast = usage.ru_utime;
+                        slast = usage.ru_stime;
                         busyloop(100000);
                 }
         }
-- 
1.8.3.1



> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 

-- 
Regards,
Chunyu Hu


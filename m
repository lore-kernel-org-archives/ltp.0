Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hannuxx@gmail.com>) id 1PYihV-0001JY-Al
	for ltp-list@lists.sourceforge.net; Fri, 31 Dec 2010 17:23:37 +0000
Received: from mail-iy0-f175.google.com ([209.85.210.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PYihU-0003Ki-15
	for ltp-list@lists.sourceforge.net; Fri, 31 Dec 2010 17:23:37 +0000
Received: by iyj18 with SMTP id 18so10836245iyj.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 31 Dec 2010 09:23:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <B13F18F8-B5AE-4E1D-84FE-1761EBF43020@gmail.com>
References: <2f593033cef8fce7afbeaf2276c867fc7c8c1da7.1293815859.git.ext-hannu.m.heikkinen@nokia.com>
	<B13F18F8-B5AE-4E1D-84FE-1761EBF43020@gmail.com>
Date: Fri, 31 Dec 2010 19:23:30 +0200
Message-ID: <AANLkTimECs+i-Fi5a87d+1uw=NKykgKKT6TDqT2RSDJe@mail.gmail.com>
From: Hannu Heikkinen <hannuxx@iki.fi>
Subject: Re: [LTP] [PATCH 1/1] open_posix_testsuite: sigqueue 9-1,
 fix sigpending handling, and check purged signal queue
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2543476883192155924=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--===============2543476883192155924==
Content-Type: multipart/alternative; boundary=90e6ba4fc4b6a301ad0498b80f5d

--90e6ba4fc4b6a301ad0498b80f5d
Content-Type: text/plain; charset=ISO-8859-1

Hi, goes to next year! :)

br
Hannu

2010/12/31 Garrett Cooper <yanegomi@gmail.com>

> No. This is an illegal linuxism. Please try again...
>
> Sent from my iPhone
>
> On Dec 31, 2010, at 9:18 AM, Hannu Heikkinen <
> ext-hannu.m.heikkinen@nokia.com> wrote:
>
> > Fix sigpending handling in sigqueue (9-1), by checking
> > current pendings from /proc/<pid>/status -> SigQ.
> > Also, added new functionality, check that purged signals
> > received correctly.
> >
> > Signed-off-by: Hannu Heikkinen <ext-hannu.m.heikkinen@nokia.com>
> > ---
> > .../conformance/interfaces/sigqueue/9-1.c          |  183
> +++++++++++++++++---
> > 1 files changed, 160 insertions(+), 23 deletions(-)
> >
> > diff --git
> a/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/9-1.c
> b/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/9-1.c
> > index e8592d5..fa8ad20 100644
> > ---
> a/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/9-1.c
> > +++
> b/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/9-1.c
> > @@ -24,63 +24,200 @@
> > #define SIGTOTEST SIGRTMIN
> > #define NUMCALLS 5
> >
> > +#include <sys/types.h>
> > +#include <sys/wait.h>
> > +#include <sys/stat.h>
> > +#include <fcntl.h>
> > #include <signal.h>
> > #include <stdio.h>
> > #include <unistd.h>
> > #include <stdlib.h>
> > +#include <string.h>
> > #include <errno.h>
> > #include "posixtest.h"
> >
> > -void myhandler(int signo, siginfo_t *info, void *context) {
> > -    printf ("Inside Handler\n");
> > +static long purged = 0;
> > +
> > +void myhandler(int signo, siginfo_t *info, void *context)
> > +{
> > +    purged++;
> > }
> >
> > -int main()
> > +int get_proc_sig(int pid, long *current_sig, long *max_sig)
> > {
> > +    int f;
> > +    char procdir[128]="";
> > +    char line[1024]="";
> > +    char *pos, *pos2;
> > +    char *sig;
> > +    char c;
> > +    long curr, max;
> > +    int len;
> > +    int ret;
> >
> > -    int pid, i;
> > -    long syslimit;
> > -    union sigval value;
> > +    snprintf(procdir, sizeof(procdir)-1, "/proc/%d/status", pid);
> > +    procdir[sizeof(procdir)-1] = '\0';
> > +
> > +    f = open(procdir, O_RDONLY);
> > +    if (f == -1)
> > +        return -1;
> > +
> > +    len = read(f, line, sizeof(line)-1);
> > +    close(f);
> > +
> > +    if (len <= 0)
> > +        return -1;
> > +    else
> > +        line[len] = '\0';
> > +
> > +    pos = strstr(line, "SigQ:");
> > +    if (pos == NULL)
> > +        return -1;
> > +
> > +    pos2 = strchr(pos, '\n');
> > +    if (pos2 == NULL)
> > +        return -1;
> > +
> > +    sig = pos;
> > +    sig[pos2-pos] = '\0';
> > +    sig = strrchr(sig, '\t');
> > +    if (sig == NULL)
> > +        return -1;
> > +
> > +    printf("%s: from proc: %s\n", __func__, sig);
> > +    if ((ret = sscanf(sig, "%ld%c%ld", &curr, &c, &max)) != 3) {
> > +        printf("%s: Matching only %d items...\n",
> > +            __func__, ret);
> > +        return -1;
> > +    }
> > +    printf("%s: %s -> matched: %ld%c%ld\n",
> > +        __func__, sig, curr, c, max);
> > +
> > +    *current_sig = curr;
> > +    *max_sig = max;
> > +
> > +    return 0;
> > +}
> > +
> > +int set_signals(sigset_t *new, sigset_t *old)
> > +{
> >    struct sigaction act;
> > +    sigset_t new_set, old_set;
> >
> >    act.sa_flags = SA_SIGINFO;
> >    act.sa_sigaction = myhandler;
> >    sigemptyset(&act.sa_mask);
> >    sigaction(SIGTOTEST, &act, 0);
> >
> > -    value.sival_int = 0;    /* 0 is just an arbitrary value */
> > -    pid = getpid();
> > +    printf("SIGRTMIN signals blocked\n");
> > +    sigemptyset(&new_set);
> > +    sigaddset(&new_set, SIGTOTEST);
> > +    sigprocmask(SIG_BLOCK, &new_set, &old_set);
> > +    *old = old_set;
> > +    *new = new_set;
> >
> > -    sighold(SIGTOTEST);
> > +    return 0;
> > +}
> >
> > -    syslimit = sysconf(_SC_SIGQUEUE_MAX);
> > +int do_purge_test(sigset_t old, long syslimit)
> > +{
> > +    int sanity = 12;
> >
> > -    printf("sigqueuemax %ld\n", syslimit);
> > -
> > -    if (syslimit == -1) {
> > -        printf("Test PASSED: Actually, test is not applicable to this
> implementation. This system has no defined limit."
> > -            " Note: it is optional whether an implementation has this
> limit, so this is"
> > -            " not a bug.\n");
> > -        return PTS_PASS;
> > +    printf("SIGRTMIN signals unblocked\n");
> > +    sigprocmask(SIG_SETMASK, &old, NULL);
> > +
> > +    while (purged < syslimit && sanity > 0) {
> > +        sleep(1);
> > +        sanity--;
> >    }
> >
> > -    for (i=0; i<syslimit; i++) {
> > -        if (sigqueue(pid, SIGTOTEST, value) != 0) {
> > -            printf("Test UNRESOLVED: call to sigqueue did not return
> success\n");
> > +    return purged;
> > +}
> > +
> > +int do_queue_test(int pid, long syslimit)
> > +{
> > +    int ret;
> > +    int i;
> > +    union sigval value;
> > +
> > +    value.sival_int = 0;    /* 0 is just an arbitrary value */
> > +
> > +    for (i = 0; i < syslimit; i++) {
> > +        errno = 0;
> > +        if ((ret = sigqueue(pid, SIGTOTEST, value)) != 0) {
> > +            printf("Test UNRESOLVED: sigqueue ERROR: ret: %d errno: %d
> (%s), "
> > +                   "sigqueues succeeded: %d, but syslimit: %d\n",
> > +                ret,
> > +                (int)errno,
> > +                strerror(errno),
> > +                i,
> > +                (int)syslimit);
> >            return PTS_UNRESOLVED;
> >        }
> >    }
> >
> > +    errno = 0;
> >    if (sigqueue(pid, SIGTOTEST, value) != -1) {
> > -        printf("Test FAILED: sigqueue did not return -1 even though the
> process has already queued {SIGQUEUE_MAX} signals that are still
> pending.\n");
> > +        printf("Test FAILED: sigqueue ERROR: ret: %d errno %d (%s). "
> > +            "sigqueue should return -1 because the process already
> queued signals, which are pending\n",
> > +            ret,
> > +            (int)errno,
> > +            strerror(errno));
> >        return PTS_FAIL;
> >    }
> > -
> > +
> >    if (errno != EAGAIN) {
> > -        printf("Test FAILED: errno was not set to [EAGAIN] even though
> the process has already queued {SIGQUEUE_MAX} signals that are still
> pending.\n");
> > +        printf("Test FAILED: errno was not set to [EAGAIN] even "
> > +            "though the process has already queued {SIGQUEUE_MAX}
> signals "
> > +            "that are still pending.\n");
> >    }
> >
> >    return PTS_PASS;
> > }
> >
> > +int main()
> > +{
> > +    long syslimit;
> > +    long curr, max;
> > +    sigset_t new_set, old_set;
> > +    int ret = PTS_FAIL;
> > +
> > +    syslimit = sysconf(_SC_SIGQUEUE_MAX);
> > +    printf("sigqueuemax %ld\n", syslimit);
> > +
> > +    if (syslimit == -1) {
> > +        printf("Test PASSED: Actually, test is not applicable to this
> implementation."
> > +            " This system has no defined limit."
> > +            " Note: it is optional whether an implementation has this
> limit, so this is"
> > +            " not a bug.\n");
> > +        return PTS_PASS;
> > +    }
> > +
> > +    sleep(1);
> > +    if (get_proc_sig(getpid(), &curr, &max) == 0) {
> > +        if (curr >= syslimit) {
> > +            printf("Test UNRESOLVED: syslimit %ld less or equal to
> current pending %ld\n",
> > +                syslimit, curr);
> > +            return PTS_UNRESOLVED;
> > +        }
> > +        printf("reducing syslimit %ld -> %ld due to current pending
> %ld\n",
> > +            syslimit,
> > +            syslimit-curr,
> > +            curr);
> > +        syslimit -= curr;
> > +    }
> >
> > +    set_signals(&new_set, &old_set);
> > +    ret = do_queue_test(getpid(), syslimit);
> > +    if (ret == PTS_PASS) {
> > +        int purged = do_purge_test(old_set, syslimit);
> > +        printf("Purged %d of %d pending signals, not-purged %d\n",
> > +            (int)purged,
> > +            (int)syslimit,
> > +            (int)(syslimit-purged));
> > +        if (purged != syslimit)
> > +            return PTS_FAIL;
> > +    }
> > +
> > +    return ret;
> > +}
> > --
> > 1.7.3
> >
>
>
> ------------------------------------------------------------------------------
> Learn how Oracle Real Application Clusters (RAC) One Node allows customers
> to consolidate database storage, standardize their database environment,
> and,
> should the need arise, upgrade to a full multi-node Oracle RAC database
> without downtime or disruption
> http://p.sf.net/sfu/oracle-sfdevnl
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>



-- 
- Only the paranoid survive - Andy Grove -

--90e6ba4fc4b6a301ad0498b80f5d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi, goes to next year! :)<div><br></div><div>br</div><div>Hannu<br><br><div=
 class=3D"gmail_quote">2010/12/31 Garrett Cooper <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:yanegomi@gmail.com">yanegomi@gmail.com</a>&gt;</span><br><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex;">
No. This is an illegal linuxism. Please try again...<br>
<br>
Sent from my iPhone<br>
<div><div></div><div class=3D"h5"><br>
On Dec 31, 2010, at 9:18 AM, Hannu Heikkinen &lt;<a href=3D"mailto:ext-hann=
u.m.heikkinen@nokia.com">ext-hannu.m.heikkinen@nokia.com</a>&gt; wrote:<br>
<br>
&gt; Fix sigpending handling in sigqueue (9-1), by checking<br>
&gt; current pendings from /proc/&lt;pid&gt;/status -&gt; SigQ.<br>
&gt; Also, added new functionality, check that purged signals<br>
&gt; received correctly.<br>
&gt;<br>
&gt; Signed-off-by: Hannu Heikkinen &lt;<a href=3D"mailto:ext-hannu.m.heikk=
inen@nokia.com">ext-hannu.m.heikkinen@nokia.com</a>&gt;<br>
&gt; ---<br>
&gt; .../conformance/interfaces/sigqueue/9-1.c =A0 =A0 =A0 =A0 =A0| =A0183 =
+++++++++++++++++---<br>
&gt; 1 files changed, 160 insertions(+), 23 deletions(-)<br>
&gt;<br>
&gt; diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sig=
queue/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigqueu=
e/9-1.c<br>
&gt; index e8592d5..fa8ad20 100644<br>
&gt; --- a/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/9=
-1.c<br>
&gt; +++ b/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/9=
-1.c<br>
&gt; @@ -24,63 +24,200 @@<br>
&gt; #define SIGTOTEST SIGRTMIN<br>
&gt; #define NUMCALLS 5<br>
&gt;<br>
&gt; +#include &lt;sys/types.h&gt;<br>
&gt; +#include &lt;sys/wait.h&gt;<br>
&gt; +#include &lt;sys/stat.h&gt;<br>
&gt; +#include &lt;fcntl.h&gt;<br>
&gt; #include &lt;signal.h&gt;<br>
&gt; #include &lt;stdio.h&gt;<br>
&gt; #include &lt;unistd.h&gt;<br>
&gt; #include &lt;stdlib.h&gt;<br>
&gt; +#include &lt;string.h&gt;<br>
&gt; #include &lt;errno.h&gt;<br>
&gt; #include &quot;posixtest.h&quot;<br>
&gt;<br>
&gt; -void myhandler(int signo, siginfo_t *info, void *context) {<br>
&gt; - =A0 =A0printf (&quot;Inside Handler\n&quot;);<br>
&gt; +static long purged =3D 0;<br>
&gt; +<br>
&gt; +void myhandler(int signo, siginfo_t *info, void *context)<br>
&gt; +{<br>
&gt; + =A0 =A0purged++;<br>
&gt; }<br>
&gt;<br>
&gt; -int main()<br>
&gt; +int get_proc_sig(int pid, long *current_sig, long *max_sig)<br>
&gt; {<br>
&gt; + =A0 =A0int f;<br>
&gt; + =A0 =A0char procdir[128]=3D&quot;&quot;;<br>
&gt; + =A0 =A0char line[1024]=3D&quot;&quot;;<br>
&gt; + =A0 =A0char *pos, *pos2;<br>
&gt; + =A0 =A0char *sig;<br>
&gt; + =A0 =A0char c;<br>
&gt; + =A0 =A0long curr, max;<br>
&gt; + =A0 =A0int len;<br>
&gt; + =A0 =A0int ret;<br>
&gt;<br>
&gt; - =A0 =A0int pid, i;<br>
&gt; - =A0 =A0long syslimit;<br>
&gt; - =A0 =A0union sigval value;<br>
&gt; + =A0 =A0snprintf(procdir, sizeof(procdir)-1, &quot;/proc/%d/status&qu=
ot;, pid);<br>
&gt; + =A0 =A0procdir[sizeof(procdir)-1] =3D &#39;\0&#39;;<br>
&gt; +<br>
&gt; + =A0 =A0f =3D open(procdir, O_RDONLY);<br>
&gt; + =A0 =A0if (f =3D=3D -1)<br>
&gt; + =A0 =A0 =A0 =A0return -1;<br>
&gt; +<br>
&gt; + =A0 =A0len =3D read(f, line, sizeof(line)-1);<br>
&gt; + =A0 =A0close(f);<br>
&gt; +<br>
&gt; + =A0 =A0if (len &lt;=3D 0)<br>
&gt; + =A0 =A0 =A0 =A0return -1;<br>
&gt; + =A0 =A0else<br>
&gt; + =A0 =A0 =A0 =A0line[len] =3D &#39;\0&#39;;<br>
&gt; +<br>
&gt; + =A0 =A0pos =3D strstr(line, &quot;SigQ:&quot;);<br>
&gt; + =A0 =A0if (pos =3D=3D NULL)<br>
&gt; + =A0 =A0 =A0 =A0return -1;<br>
&gt; +<br>
&gt; + =A0 =A0pos2 =3D strchr(pos, &#39;\n&#39;);<br>
&gt; + =A0 =A0if (pos2 =3D=3D NULL)<br>
&gt; + =A0 =A0 =A0 =A0return -1;<br>
&gt; +<br>
&gt; + =A0 =A0sig =3D pos;<br>
&gt; + =A0 =A0sig[pos2-pos] =3D &#39;\0&#39;;<br>
&gt; + =A0 =A0sig =3D strrchr(sig, &#39;\t&#39;);<br>
&gt; + =A0 =A0if (sig =3D=3D NULL)<br>
&gt; + =A0 =A0 =A0 =A0return -1;<br>
&gt; +<br>
&gt; + =A0 =A0printf(&quot;%s: from proc: %s\n&quot;, __func__, sig);<br>
&gt; + =A0 =A0if ((ret =3D sscanf(sig, &quot;%ld%c%ld&quot;, &amp;curr, &am=
p;c, &amp;max)) !=3D 3) {<br>
&gt; + =A0 =A0 =A0 =A0printf(&quot;%s: Matching only %d items...\n&quot;,<b=
r>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0__func__, ret);<br>
&gt; + =A0 =A0 =A0 =A0return -1;<br>
&gt; + =A0 =A0}<br>
&gt; + =A0 =A0printf(&quot;%s: %s -&gt; matched: %ld%c%ld\n&quot;,<br>
&gt; + =A0 =A0 =A0 =A0__func__, sig, curr, c, max);<br>
&gt; +<br>
&gt; + =A0 =A0*current_sig =3D curr;<br>
&gt; + =A0 =A0*max_sig =3D max;<br>
&gt; +<br>
&gt; + =A0 =A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +int set_signals(sigset_t *new, sigset_t *old)<br>
&gt; +{<br>
&gt; =A0 =A0struct sigaction act;<br>
&gt; + =A0 =A0sigset_t new_set, old_set;<br>
&gt;<br>
&gt; =A0 =A0act.sa_flags =3D SA_SIGINFO;<br>
&gt; =A0 =A0act.sa_sigaction =3D myhandler;<br>
&gt; =A0 =A0sigemptyset(&amp;act.sa_mask);<br>
&gt; =A0 =A0sigaction(SIGTOTEST, &amp;act, 0);<br>
&gt;<br>
&gt; - =A0 =A0value.sival_int =3D 0; =A0 =A0/* 0 is just an arbitrary value=
 */<br>
&gt; - =A0 =A0pid =3D getpid();<br>
&gt; + =A0 =A0printf(&quot;SIGRTMIN signals blocked\n&quot;);<br>
&gt; + =A0 =A0sigemptyset(&amp;new_set);<br>
&gt; + =A0 =A0sigaddset(&amp;new_set, SIGTOTEST);<br>
&gt; + =A0 =A0sigprocmask(SIG_BLOCK, &amp;new_set, &amp;old_set);<br>
&gt; + =A0 =A0*old =3D old_set;<br>
&gt; + =A0 =A0*new =3D new_set;<br>
&gt;<br>
&gt; - =A0 =A0sighold(SIGTOTEST);<br>
&gt; + =A0 =A0return 0;<br>
&gt; +}<br>
&gt;<br>
&gt; - =A0 =A0syslimit =3D sysconf(_SC_SIGQUEUE_MAX);<br>
&gt; +int do_purge_test(sigset_t old, long syslimit)<br>
&gt; +{<br>
&gt; + =A0 =A0int sanity =3D 12;<br>
&gt;<br>
&gt; - =A0 =A0printf(&quot;sigqueuemax %ld\n&quot;, syslimit);<br>
&gt; -<br>
&gt; - =A0 =A0if (syslimit =3D=3D -1) {<br>
&gt; - =A0 =A0 =A0 =A0printf(&quot;Test PASSED: Actually, test is not appli=
cable to this implementation. This system has no defined limit.&quot;<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0&quot; Note: it is optional whether an implem=
entation has this limit, so this is&quot;<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0&quot; not a bug.\n&quot;);<br>
&gt; - =A0 =A0 =A0 =A0return PTS_PASS;<br>
&gt; + =A0 =A0printf(&quot;SIGRTMIN signals unblocked\n&quot;);<br>
&gt; + =A0 =A0sigprocmask(SIG_SETMASK, &amp;old, NULL);<br>
&gt; +<br>
&gt; + =A0 =A0while (purged &lt; syslimit &amp;&amp; sanity &gt; 0) {<br>
&gt; + =A0 =A0 =A0 =A0sleep(1);<br>
&gt; + =A0 =A0 =A0 =A0sanity--;<br>
&gt; =A0 =A0}<br>
&gt;<br>
&gt; - =A0 =A0for (i=3D0; i&lt;syslimit; i++) {<br>
&gt; - =A0 =A0 =A0 =A0if (sigqueue(pid, SIGTOTEST, value) !=3D 0) {<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0printf(&quot;Test UNRESOLVED: call to sigqueu=
e did not return success\n&quot;);<br>
&gt; + =A0 =A0return purged;<br>
&gt; +}<br>
&gt; +<br>
&gt; +int do_queue_test(int pid, long syslimit)<br>
&gt; +{<br>
&gt; + =A0 =A0int ret;<br>
&gt; + =A0 =A0int i;<br>
&gt; + =A0 =A0union sigval value;<br>
&gt; +<br>
&gt; + =A0 =A0value.sival_int =3D 0; =A0 =A0/* 0 is just an arbitrary value=
 */<br>
&gt; +<br>
&gt; + =A0 =A0for (i =3D 0; i &lt; syslimit; i++) {<br>
&gt; + =A0 =A0 =A0 =A0errno =3D 0;<br>
&gt; + =A0 =A0 =A0 =A0if ((ret =3D sigqueue(pid, SIGTOTEST, value)) !=3D 0)=
 {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0printf(&quot;Test UNRESOLVED: sigqueue ERROR:=
 ret: %d errno: %d (%s), &quot;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;sigqueues succeeded: %d, b=
ut syslimit: %d\n&quot;,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(int)errno,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strerror(errno),<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(int)syslimit);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0return PTS_UNRESOLVED;<br>
&gt; =A0 =A0 =A0 =A0}<br>
&gt; =A0 =A0}<br>
&gt;<br>
&gt; + =A0 =A0errno =3D 0;<br>
&gt; =A0 =A0if (sigqueue(pid, SIGTOTEST, value) !=3D -1) {<br>
&gt; - =A0 =A0 =A0 =A0printf(&quot;Test FAILED: sigqueue did not return -1 =
even though the process has already queued {SIGQUEUE_MAX} signals that are =
still pending.\n&quot;);<br>
&gt; + =A0 =A0 =A0 =A0printf(&quot;Test FAILED: sigqueue ERROR: ret: %d err=
no %d (%s). &quot;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0&quot;sigqueue should return -1 because the p=
rocess already queued signals, which are pending\n&quot;,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0ret,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0(int)errno,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0strerror(errno));<br>
&gt; =A0 =A0 =A0 =A0return PTS_FAIL;<br>
&gt; =A0 =A0}<br>
&gt; -<br>
&gt; +<br>
&gt; =A0 =A0if (errno !=3D EAGAIN) {<br>
&gt; - =A0 =A0 =A0 =A0printf(&quot;Test FAILED: errno was not set to [EAGAI=
N] even though the process has already queued {SIGQUEUE_MAX} signals that a=
re still pending.\n&quot;);<br>
&gt; + =A0 =A0 =A0 =A0printf(&quot;Test FAILED: errno was not set to [EAGAI=
N] even &quot;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0&quot;though the process has already queued {=
SIGQUEUE_MAX} signals &quot;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0&quot;that are still pending.\n&quot;);<br>
&gt; =A0 =A0}<br>
&gt;<br>
&gt; =A0 =A0return PTS_PASS;<br>
&gt; }<br>
&gt;<br>
&gt; +int main()<br>
&gt; +{<br>
&gt; + =A0 =A0long syslimit;<br>
&gt; + =A0 =A0long curr, max;<br>
&gt; + =A0 =A0sigset_t new_set, old_set;<br>
&gt; + =A0 =A0int ret =3D PTS_FAIL;<br>
&gt; +<br>
&gt; + =A0 =A0syslimit =3D sysconf(_SC_SIGQUEUE_MAX);<br>
&gt; + =A0 =A0printf(&quot;sigqueuemax %ld\n&quot;, syslimit);<br>
&gt; +<br>
&gt; + =A0 =A0if (syslimit =3D=3D -1) {<br>
&gt; + =A0 =A0 =A0 =A0printf(&quot;Test PASSED: Actually, test is not appli=
cable to this implementation.&quot;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0&quot; This system has no defined limit.&quot=
;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0&quot; Note: it is optional whether an implem=
entation has this limit, so this is&quot;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0&quot; not a bug.\n&quot;);<br>
&gt; + =A0 =A0 =A0 =A0return PTS_PASS;<br>
&gt; + =A0 =A0}<br>
&gt; +<br>
&gt; + =A0 =A0sleep(1);<br>
&gt; + =A0 =A0if (get_proc_sig(getpid(), &amp;curr, &amp;max) =3D=3D 0) {<b=
r>
&gt; + =A0 =A0 =A0 =A0if (curr &gt;=3D syslimit) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0printf(&quot;Test UNRESOLVED: syslimit %ld le=
ss or equal to current pending %ld\n&quot;,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0syslimit, curr);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0return PTS_UNRESOLVED;<br>
&gt; + =A0 =A0 =A0 =A0}<br>
&gt; + =A0 =A0 =A0 =A0printf(&quot;reducing syslimit %ld -&gt; %ld due to c=
urrent pending %ld\n&quot;,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0syslimit,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0syslimit-curr,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0curr);<br>
&gt; + =A0 =A0 =A0 =A0syslimit -=3D curr;<br>
&gt; + =A0 =A0}<br>
&gt;<br>
&gt; + =A0 =A0set_signals(&amp;new_set, &amp;old_set);<br>
&gt; + =A0 =A0ret =3D do_queue_test(getpid(), syslimit);<br>
&gt; + =A0 =A0if (ret =3D=3D PTS_PASS) {<br>
&gt; + =A0 =A0 =A0 =A0int purged =3D do_purge_test(old_set, syslimit);<br>
&gt; + =A0 =A0 =A0 =A0printf(&quot;Purged %d of %d pending signals, not-pur=
ged %d\n&quot;,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0(int)purged,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0(int)syslimit,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0(int)(syslimit-purged));<br>
&gt; + =A0 =A0 =A0 =A0if (purged !=3D syslimit)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0return PTS_FAIL;<br>
&gt; + =A0 =A0}<br>
&gt; +<br>
&gt; + =A0 =A0return ret;<br>
&gt; +}<br>
&gt; --<br>
&gt; 1.7.3<br>
&gt;<br>
<br>
---------------------------------------------------------------------------=
---<br>
Learn how Oracle Real Application Clusters (RAC) One Node allows customers<=
br>
to consolidate database storage, standardize their database environment, an=
d,<br>
should the need arise, upgrade to a full multi-node Oracle RAC database<br>
without downtime or disruption<br>
<a href=3D"http://p.sf.net/sfu/oracle-sfdevnl" target=3D"_blank">http://p.s=
f.net/sfu/oracle-sfdevnl</a><br>
_______________________________________________<br>
Ltp-list mailing list<br>
<a href=3D"mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourceforg=
e.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/ltp-list" target=3D=
"_blank">https://lists.sourceforge.net/lists/listinfo/ltp-list</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br>- Only the =
paranoid survive - Andy Grove -<br>
</div>

--90e6ba4fc4b6a301ad0498b80f5d--


--===============2543476883192155924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
--===============2543476883192155924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2543476883192155924==--


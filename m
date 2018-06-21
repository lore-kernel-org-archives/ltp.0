From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 21 Jun 2018 16:10:12 +0200
Subject: [LTP] [PATCH v2 3/3] cve/cve-2018-1000001: Add Realpath Buffer
 Underflow test
In-Reply-To: <20180621093419.GA22873@rei>
References: <20180620154843.27565-1-pvorel@suse.cz>
 <20180620154843.27565-3-pvorel@suse.cz>
 <20180621093419.GA22873@rei>
Message-ID: <20180621141012.362aoktmiyfe5wjk@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Cyril,

thanks for review. I'll send changes in v3 + see comments bellow.

> I'm not sure if it's a good idea to separate the CVE testcases like
> that, CVE is a CVE and as it looks this has been caused by a change in
> the Linux kernel anyways.

> So maybe we should put this into a syscalls/getcwd/ directory after all
> as the cve identifiers are not really human readable and getcwd05.c
> sounds better to me.
Agree, added there for v3.


> > +++ b/runtest/cve
> > @@ -33,3 +33,4 @@ cve-2017-17052 cve-2017-17052
> >  cve-2017-16939 cve-2017-16939
> >  cve-2017-17053 cve-2017-17053
> >  cve-2018-5803 sctp_big_chunk
> > +cve-2018-1000001_libc_realpath_buffer_underflow cve-2018-1000001

> This long name loos kind of ugly, I would vote for having only the cve
> identifier in the test id here.
OK. + I added it into these runfiles (these where getcwd0[1-4] are + into CVE
itself):
runtest/cve
 cve-2018-5803 sctp_big_chunk
+cve-2018-1000001 getcwd05

runtest/ltplite
runtest/stress.part3
runtest/syscalls
 getcwd04 getcwd04
+getcwd05 getcwd05

...
> > +	if (TST_RET_PTR != NULL) {
> > +		tst_res(TFAIL, "syscall didn't return NULL: '%s'",
> > +				(char *)TST_RET_PTR);

> I doubt that we need the cast to char* here.

We do:
getcwd05.c: In function ‘run’:
../../../../include/tst_test.h:53:40: warning: format ‘%s’ expects argument of type ‘char *’, but argument 5 has type ‘void *’ [-Wformat=]
  tst_res_(__FILE__, __LINE__, (ttype), (arg_fmt), ##__VA_ARGS__)

So is something wrong in my TESTPTR() implementation?


Kind regards,
Petr

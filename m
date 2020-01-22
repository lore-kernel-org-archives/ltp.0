From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 22 Jan 2020 17:41:34 +0100
Subject: [LTP] [PATCH 0/4] TI-RPC: enhancements (pkg-config, libntirpc,
 travis)
In-Reply-To: <20200122144917.GB29412@rei>
References: <20200108103413.29096-1-pvorel@suse.cz>
 <20200122144917.GB29412@rei>
Message-ID: <20200122164134.GB20996@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> I've looked over the patchset and it looks fine to me, acked.
Thanks for your review and ack.
Unfortunately there are errors, so I'm working on v2.

Missing AC_SUBST in first patch for TI-RPC CFLAGS and LIBS hide them,
when fixed it shows that TI-RPC is really just for libtirpc - not for glibc
nor for libntirpc due missing xdr_{u_,}char dependency (although I got some
reply on ticket for libntirpc [1]: use xdr_get{u,}int8 and xdr_put{u,}int8 in
libntirpc, so it might be fixed). This is dependency for both TI-RPC tests and
basic RPC tests (testcases/network/rpc/basic_tests). libntirpc might have also some
missing dependency for TI-RPC (pmap_unset, which is in glibc).

I still don't know whether current goal for libntirpc is to be API
compatible with libtirpc (similar to kerberos, which override libtirpc functions
with it's gssrpc_* variants via gssrpc/rename.h [2]).

On the other hand svc_unreg() is in both libtirpc and libntirpc, but missing in
glibc.

But I'm going to merge commit travis: Merge debian.cross-compile.*.sh
which is correct.

BTW I also get some "funny" errors on s390 on travis [3]:
install: error writing '/root/ltp-install/testcases/bin/mkdir05': No space left on device
(I never experienced lack of space on travis on intel, I guess non-intel archs are a bit experimental.)

Kind regards,
Petr

[1] https://github.com/nfs-ganesha/ntirpc/issues/200
[2] https://github.com/krb5/krb5/blob/master/src/include/gssrpc/rename.h
[3] https://api.travis-ci.org/v3/job/640230579/log.txt

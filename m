From: Ping Fang <pifang@redhat.com>
Date: Thu, 10 Oct 2019 16:16:50 +0800
Subject: [LTP] [PATCH] acct: fix version check on big endian system
In-Reply-To: <2126517382.5475715.1570692951519.JavaMail.zimbra@redhat.com>
References: <20191010063750.9605-1-pifang@redhat.com>
 <20191010064324.GA2615@dhcp-0-148.nay.redhat.com>
 <2126517382.5475715.1570692951519.JavaMail.zimbra@redhat.com>
Message-ID: <20191010081650.GB2615@dhcp-0-148.nay.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Oct 10, 2019 at 03:35:51AM -0400, Jan Stancek wrote:
> 
> ----- Original Message -----
> > On Thu, Oct 10, 2019 at 02:37:50PM +0800, Ping Fang wrote:
> > > ac_version = ACCT_VERION | ACCT_BYTEORDER
> > > which is 0x83 (131) on big endian system.
> > > 
> > > failure output:
> > > tst_kconfig.c:62: INFO: Parsing kernel config
> > > '/boot/config-4.18.0-147.el8.s390x'
> > > tst_test.c:1118: INFO: Timeout per run is 0h 05m 00s
> > > tst_kconfig.c:62: INFO: Parsing kernel config
> > > '/boot/config-4.18.0-147.el8.s390x'
> > > acct02.c:239: INFO: Verifying using 'struct acct_v3'
> > > acct02.c:192: INFO: == entry 1 ==
> > > acct02.c:147: INFO: ac_version != 3 (131)
> > > acct02.c:192: INFO: == entry 2 ==
> > > acct02.c:82: INFO: ac_comm != 'acct02_helper' ('acct02')
> > > acct02.c:133: INFO: ac_exitcode != 32768 (0)
> > > acct02.c:141: INFO: ac_ppid != 34501 (34500)
> > > acct02.c:147: INFO: ac_version != 3 (131)
> > > acct02.c:182: FAIL: end of file reached
> > > 
> > > Signed-off-by: Ping Fang <pifang@redhat.com>
> > > ---
> > >  testcases/kernel/syscalls/acct/acct02.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/testcases/kernel/syscalls/acct/acct02.c
> > > b/testcases/kernel/syscalls/acct/acct02.c
> > > index 7c2a27046..c513b2145 100644
> > > --- a/testcases/kernel/syscalls/acct/acct02.c
> > > +++ b/testcases/kernel/syscalls/acct/acct02.c
> > > @@ -142,7 +142,8 @@ static int verify_acct(void *acc, int elap_time)
> > >  		ret = 1;
> > >  	}
> > >  
> > > -	if (ACCT_MEMBER_V3(ac_version) != 3) {
> > > +	/* In big endian system accout version have a ACCT_BYTEORDER 0x80 flag*/
> > > +	if (ACCT_MEMBER_V3(ac_version) != 3 || ACC_MEMBER_V3(ac_version) != 131)
> > > {
> > 					    ^^ should be &&.
> > >  		tst_res(TINFO, "ac_version != 3 (%d)",
> > >  			ACCT_MEMBER_V3(ac_version));
> > >  		ret = 1;
> > > --
> > > 2.21.0
> 
> Can we incorporate ACCT_BYTEORDER into that check?
Thanks for your advice, I will post v2.
> 
> Kernel appears to use it at least since 2.6.12-rc2. We would just need
> define it for !HAVE_STRUCT_ACCT_V3 case.
> 
> diff --git a/include/lapi/acct.h b/include/lapi/acct.h
> index ebd65bbf4df7..112ee48d8aee 100644
> --- a/include/lapi/acct.h
> +++ b/include/lapi/acct.h
> @@ -64,6 +64,13 @@ enum {
>         ACORE = 0x08,
>         AXSIG = 0x10
>  };
> +
> +# if __BYTE_ORDER == __BIG_ENDIAN
> +# define ACCT_BYTEORDER  0x80
> +# elif __BYTE_ORDER == __LITTLE_ENDIAN
> +# define ACCT_BYTEORDER  0x00
> +# endif
> +
>  #endif /* HAVE_STRUCT_ACCT_V3 */
>  
>  #endif /* LAPI_ACCT_H */
> diff --git a/testcases/kernel/syscalls/acct/acct02.c b/testcases/kernel/syscalls/acct/acct02.c
> index 7c2a270465c5..4d95aafec3e1 100644
> --- a/testcases/kernel/syscalls/acct/acct02.c
> +++ b/testcases/kernel/syscalls/acct/acct02.c
> @@ -142,7 +142,7 @@ static int verify_acct(void *acc, int elap_time)
>                 ret = 1;
>         }
>  
> -       if (ACCT_MEMBER_V3(ac_version) != 3) {
> +       if (ACCT_MEMBER_V3(ac_version) != (3 | ACCT_BYTEORDER)) {
>                 tst_res(TINFO, "ac_version != 3 (%d)",
>                         ACCT_MEMBER_V3(ac_version));
>                 ret = 1;

From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 9 Nov 2020 15:10:48 +0100
Subject: [LTP] [PATCH v2] Add tst_secureboot_enabled() helper function
In-Reply-To: <20201109135627.GA18105@yuki.lan>
References: <20201109133245.10879-1-mdoucha@suse.cz>
 <20201109135627.GA18105@yuki.lan>
Message-ID: <9d91a462-9aa1-eb1f-6bfc-c2db28967840@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 09. 11. 20 14:56, Cyril Hrubis wrote:
> Hi!
>> diff --git a/configure.ac b/configure.ac
>> index 03e4e09c9..d9ca5ad38 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -296,6 +296,7 @@ LTP_CHECK_CAPABILITY_SUPPORT
>>  LTP_CHECK_CC_WARN_OLDSTYLE
>>  LTP_CHECK_CLONE_SUPPORTS_7_ARGS
>>  LTP_CHECK_CRYPTO
>> +LTP_CHECK_EFIVAR
>>  LTP_CHECK_FORTIFY_SOURCE
>>  LTP_CHECK_KERNEL_DEVEL
>>  LTP_CHECK_KEYUTILS_SUPPORT
>> diff --git a/include/mk/config.mk.in b/include/mk/config.mk.in
>> index 427608a17..cffd11245 100644
>> --- a/include/mk/config.mk.in
>> +++ b/include/mk/config.mk.in
>> @@ -56,8 +56,8 @@ libdir			:= @libdir@
>>  mandir			:= @mandir@
>>  
>>  CPPFLAGS		:= @CPPFLAGS@
>> -CFLAGS			:= @CFLAGS@
>> -LDLIBS			:= @LIBS@
>> +CFLAGS			:= @CFLAGS@ @EFIVAR_CFLAGS@
>> +LDLIBS			:= @LIBS@ @EFIVAR_LIBS@
> 
> Please do not do this.
> 
> This should be handled like any other library, i.e. we should define
> EFIVAR_CFLAGS and EFIVAR_LIBS and use them in respective Makefile.

OK. Could you add some explanation of the policy for library
dependencies to the build system docs later? Thanks.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

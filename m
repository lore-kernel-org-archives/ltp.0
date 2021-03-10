From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 10 Mar 2021 18:21:35 +0100
Subject: [LTP] [PATCH] syscalls: Use anonymous .resource_files for
 docparse
In-Reply-To: <b11680c3-7878-b06b-e87a-8991bd3cb305@163.com>
References: <20210303023235.431238-1-yangx.jy@cn.fujitsu.com>
 <YEigO2gryF1Kp6Gq@pevik>
 <b11680c3-7878-b06b-e87a-8991bd3cb305@163.com>
Message-ID: <YEkAH6xJlSK99bp+@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yang,

> On 3/10/21 6:32 PM, Petr Vorel wrote:
> > Hi,

> > > Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > > -static const char *const resource_files[] = {
> > > -	TEST_APP,
> > > -	NULL,
> > > -};
> > > -
> > >   static struct tst_test test = {
> > >   	.test_all = verify_creat,
> > >   	.needs_checkpoints = 1,
> > >   	.forks_child = 1,
> > > -	.resource_files = resource_files,
> > > +	.resource_files = (const char *const []) {
> > > +		TEST_APP,
> > Don't we want to drop TEST_APP definition and use file directly?
> > Having TEST_APP does not say much.

> Hi Petr,


> I can use file name directly in v2 patch.
OK. I'd like to know the others opinion (precedent).

> Do you agree to use anonymous .resource_files for now? or is it better to
> keep it?
I guess yes, we've already started to use it.

> > Not sure how far we should go with moving everything into inline anonymous
> > definitions (it'd be nice if docparse was able to just expand macros, but that
> > would be way too slow).

> I agree that expanding macros or structs is the nicer way but

> we need to do some investigation about it.
gcc -E foo.c would do expansion for us. But not sure if it's worth of runtime.
Because problem of missing definitions will be on other places and we don't want
to get rid of definitions. e.g. I planned to add some tag definitions (for
"linux-git", ...) as Martin Doucha suggested, but this would not work until
we expand macros.

Kind regards,
Petr

> Best Regards,

> Xiao Yang

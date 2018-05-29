From: =?unknown-8bit?q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Date: Tue, 29 May 2018 18:32:56 +0200
Subject: [LTP] [RFC PATCH 6/9] testcases: wc: Add "unrecognized option"
 as TCONF
In-Reply-To: <20180516100055.5mrh74e3o74gy3lo@dell5510>
References: <20180423094639.14612-1-mylene.josserand@bootlin.com>
 <20180423094639.14612-7-mylene.josserand@bootlin.com>
 <20180516100055.5mrh74e3o74gy3lo@dell5510>
Message-ID: <20180529183256.7ae8254e@dell-desktop.home>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hello Petr,

On Wed, 16 May 2018 12:00:55 +0200
Petr Vorel <pvorel@suse.cz> wrote:

> Hi Mylène,
> > In case we are using Busybox, for example, some options
> > may not available and leads to a test failure.
> > This commit adds "unrecognized option" parsing to return the
> > test as a TCONF and not FAIL anymore.  
> 
> > Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> > ---
> >  testcases/commands/wc/wc01.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)  
> 
> > diff --git a/testcases/commands/wc/wc01.sh b/testcases/commands/wc/wc01.sh
> > index e72819c51..74d69e254 100755
> > --- a/testcases/commands/wc/wc01.sh
> > +++ b/testcases/commands/wc/wc01.sh
> > @@ -40,7 +40,7 @@ wc_test()  
> 
> >  	eval $wc_cmd > temp 2>&1
> >  	if [ $? -ne 0 ]; then
> > -		grep -q -E "unknown option|invalid option" temp
> > +		grep -q -E "unknown option|invalid option|unrecognized option" temp  
> What exactly needs "unrecognized option".
> I haven't found it in busybox sources neither in busybox git log.

Just in case, this is what I get with my busybox (v1.24.1):

# wc --max-line-length
wc: unrecognized option '--max-line-length'
BusyBox v1.24.1 (2018-02-10 17:35:25 CET) multi-call binary.

Usage: wc [-clwL] [FILE]...

I looked very quickly and it seems to be glibc with "getopt" function
that prints this error:
https://sourceware.org/git/?p=glibc.git;a=blob;f=posix/getopt.c#l309

> 
> >  		if [ $? -eq 0 ]; then
> >  			tst_res TCONF "$wc_cmd not supported."
> >  		else  
> 
> 
> Kind regards,
> Petr

Best regards,

-- 
Mylène Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

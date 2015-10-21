From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Wed, 21 Oct 2015 10:47:17 +0800
Subject: [LTP] [PATCH v9 6/8] lib6/getaddrinfo_01.c: Cleanup
In-Reply-To: <5625F654.7090602@oracle.com>
References: <561CE0B0.2000801@oracle.com>
 <1444810884-32508-1-git-send-email-zenglg.jy@cn.fujitsu.com>
 <1444810884-32508-6-git-send-email-zenglg.jy@cn.fujitsu.com>
 <5625F654.7090602@oracle.com>
Message-ID: <1445395637.1125.24.camel@G08FNSTD140232>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

On Tue, 2015-10-20 at 11:07 +0300, Alexey Kodanev wrote:
> Hi,
> On 10/14/2015 11:21 AM, Zeng Linggang wrote:
> > * Add 'static' before some functions and global variables.
> > * Remove cleanup() function.
> > * Remove useless comments.
> > * In every test function, using TINFO instead of TPASS
> >    marks the success of each inner test.
> > * Some cleanup.
> 
> Sorry for delay, I was going to push the patch-set but encountered with 
> a lot of warnings produced by checkpatch utility. Basically, they are 
> all because of either "else is not generally usefull after break or 
> return" or "quoted string split across lines". Then I noted that 
> test-cases there have wrong structure, comments are below.
> 
> Also,
> asapi_06.c: "commit description ... possible unwrapped" - you can trim 
> commit id a little, it will still be accessable.
> 

Hmm, I found the 'checkpatch.pl' which I used is a little out of date,
it did not output this ERROR.

> 
> >   
> > -void gaiv4(void)
> > +/* getaddrinfo tests (v4) */
> > +static void gaiv4(void)
> >   {
> >   	struct addrinfo *aires, hints, *pai;
> >   	char hostname[MAXHOSTNAMELEN + 1];
> > @@ -132,13 +108,18 @@ void gaiv4(void)
> >   				 psin ? psin->sin_family : 0,
> >   				 psin ? psin->sin_port : 0,
> >   				 psin ? htons(psin->sin_port) : 0);
> > -		} else
> > -			tst_resm(TPASS, "getaddrinfo IPv4 basic lookup");
> > -		freeaddrinfo(aires);
> > -	} else
> > -		tst_resm(TEST_RETURN ? TFAIL : TPASS, "getaddrinfo IPv4 basic "
> > +			freeaddrinfo(aires);
> > +			return;
> > +		} else {
> > +			tst_resm(TINFO, "getaddrinfo IPv4 basic lookup");
> > +			freeaddrinfo(aires);
> > +		}
> > +	} else {
> > +		tst_resm(TFAIL, "getaddrinfo IPv4 basic "
> >   			 "lookup (\"%s\") returns %ld (\"%s\")", hostname,
> >   			 TEST_RETURN, gai_strerror(TEST_RETURN));
> > +		return;
> > +	}
> >   
> 
> If you write the description of the particular test-case before the 
> test, you don't need to repeat the same description in each TPASS/TFAIL 
> messages after. Test-case should end with either TPASS or TFAIL, not 
> TINFO. Therefore all test-cases below could be something like this:
> 
> tst_resm(TINFO, "getaddrinfo IPv4 basic lookup");
> TEST(...);
> if (!TEST_RETURN) {
>      if (error) {
>          tst_resm(TFAIL, "");
>          return;
>      }
> 
>      tst_resm(TPASS, "test finished");
> } else {
>      tst_resm(TFAIL, "...");
> }
> 

This is OK.

Thanks and best regards,
Zeng

> Best regards,
> Alexey
> 



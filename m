From: Khem Raj <raj.khem@gmail.com>
Date: Wed, 27 Jul 2016 08:20:42 -0700
Subject: [LTP] [PATCH V3 14/23] shmat1: Cover GNU specific code under
	__USE_GNU
In-Reply-To: <20160727141725.GC11986@rei.lan>
References: <20160722042656.22346-1-raj.khem@gmail.com>
 <20160722042656.22346-14-raj.khem@gmail.com> <20160727141725.GC11986@rei.lan>
Message-ID: <FEF592A7-39E2-4BA1-BDBC-A5CCA84D5CAA@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


> On Jul 27, 2016, at 7:17 AM, Cyril Hrubis <chrubis@suse.cz> wrote:
> 
> Hi!
>> +#if defined(__i386__) && defined(__USE_GNU)
> 
> Hmm, shouldn't this rather be defined(__GLIBC__) ?
> 
> As far as I can tell __USE_GNU is enabled if _GNU_SOURCE is defined
> while __GLIBC__ is defined in glibc unconditionally.

Probably, yes

> 
> --
> Cyril Hrubis
> chrubis@suse.cz

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 204 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160727/30dae79a/attachment.sig>

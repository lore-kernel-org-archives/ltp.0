From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 12 Apr 2016 10:40:49 +0200
Subject: [LTP] Pre-release LTP build
In-Reply-To: <1944071328.394698.1460449773165.JavaMail.zimbra@redhat.com>
References: <20160411172305.GC3466@rei.lan>
 <1944071328.394698.1460449773165.JavaMail.zimbra@redhat.com>
Message-ID: <20160412084049.GA24915@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I do. At least RHEL5.6 is going to be around for another year.
> 
> I have repeatedly built your patch-series on RHEL5.6 x86_64, which works
> fine. But as you pointed out 32bit version fails, other arches possibly too.
> 
> My first thought was some kind of lock, so we don't have to care
> about each architecture separately.

I think that easiest solution would be copying the assembler the builtin
produces and using it as a fallback. That would have to be done per
arch, but the rest of the code could be left untouched.

-- 
Cyril Hrubis
chrubis@suse.cz

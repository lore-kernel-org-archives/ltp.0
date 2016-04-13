From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 13 Apr 2016 15:30:42 +0200
Subject: [LTP] Pre-release LTP build
In-Reply-To: <166413638.832919.1460552869855.JavaMail.zimbra@redhat.com>
References: <20160411172305.GC3466@rei.lan>
 <1944071328.394698.1460449773165.JavaMail.zimbra@redhat.com>
 <20160412084049.GA24915@rei.lan>
 <1180846583.442810.1460462279148.JavaMail.zimbra@redhat.com>
 <20160412122307.GA2562@rei.suse.cz>
 <1314010537.480730.1460468377766.JavaMail.zimbra@redhat.com>
 <20160412142449.GC2875@rei.suse.cz>
 <166413638.832919.1460552869855.JavaMail.zimbra@redhat.com>
Message-ID: <20160413133042.GG10941@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I'll post a series that goes this way shortly. I've based it on kernel
> atomic_add_return for architectures that are accessible for me. I tested
> it only on RHEL5.6 (gcc 4.1.2), which I think is the oldest active
> RHEL release at the moment.
> 
> What arches do you care about, that have gcc-3.3?

I would say that we should work fine on x86 and x86_64. The rest of the
archs are either new ones that does not have this problem or not easy to
get. Well there may be old mac machines that runs Linux just fine but if
you are runing LTP on Linux on ppc mac you should be able to write a few
lines of inline assembler...

-- 
Cyril Hrubis
chrubis@suse.cz

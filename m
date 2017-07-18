From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 18 Jul 2017 15:40:29 +0200
Subject: [LTP] [PATCH 4/4] Test for CVE-2016-10044 mark AIO pseudo-fs
 noexec
In-Reply-To: <8760eqqffy.fsf@our.domain.is.not.set>
References: <20170718073319.23543-1-rpalethorpe@suse.com>
 <20170718073319.23543-5-rpalethorpe@suse.com>
 <1513116395.54444036.1500364708984.JavaMail.zimbra@redhat.com>
 <8760eqqffy.fsf@our.domain.is.not.set>
Message-ID: <20170718134028.GB22620@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> As far as I am aware the alternatives are to use libaio, which seems
> like overkill for this test. Or to include the AIO ABI definitions
> inside the test. I don't think there is a comparable sys/ header.
> 
> I don't really mind using libaio if that is preferred?

The test only needs aio context type we may as well pass a pointer to
unsigned long to the syscall and be done with it...

-- 
Cyril Hrubis
chrubis@suse.cz

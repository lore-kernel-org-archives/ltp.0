From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 20 Jan 2020 13:30:56 +0100
Subject: [LTP] [PATCH 2/3] tst_device.h: Use lapi/syscalls.h instead of
 <sys/syscall.h>
In-Reply-To: <20200120120309.GA24136@dell5510>
References: <20200117113715.22786-1-pvorel@suse.cz>
 <20200117113715.22786-3-pvorel@suse.cz> <20200120103108.GA15405@dell5510>
 <558281761.2778139.1579517819187.JavaMail.zimbra@redhat.com>
 <20200120120309.GA24136@dell5510>
Message-ID: <0409fc38-c432-e2f1-309e-f506826416d3@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 1/20/20 1:03 PM, Petr Vorel wrote:
> But none of lapi/syscalls.h use is in the API headers (only in API C and tests)

And you could avoid #including lapi/syscalls.h in API headers by simply
moving the implementation of tst_dev_sync() to lib/tst_device.c.

Why do you guys use static inline functions so much anyway? There are no
technical reasons to do that except for default main().

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

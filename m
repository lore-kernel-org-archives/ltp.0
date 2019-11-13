From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 13 Nov 2019 00:58:05 -0500 (EST)
Subject: [LTP] [PATCH v2 0/3] fanotify musl fixes
In-Reply-To: <20191113005626.19585-1-petr.vorel@gmail.com>
References: <20191113005626.19585-1-petr.vorel@gmail.com>
Message-ID: <902626520.11813984.1573624685378.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi,
> 
> I generalized previous patch set a bit via autotools checks and also add
> other cleanup (base decisions whether to define fallback definitions on
> autotools checks).
> 
> BTW I tempted to use <linux/fanotify.h>, but not only we'd have to
> define fanotify_mark(), but we'd also lost libc header testing.
> 
> https://travis-ci.org/pevik/ltp/builds/611138280
> (openSUSE Tumbleweed failure is not related to this change)

Hi Petr,

looks good to me. 2/3 rework makes it easier to follow too.
I tried it on couple old/new RHEL distros with no issues.

Acked-by: Jan Stancek <jstancek@redhat.com>


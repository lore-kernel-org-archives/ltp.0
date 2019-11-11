From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 11 Nov 2019 05:38:54 -0500 (EST)
Subject: [LTP] LTP: diotest4.c:476: read to read-only space. returns 0:
 Success
In-Reply-To: <20191111083815.GA29540@infradead.org>
References: <CA+G9fYtmA5F174nTAtyshr03wkSqMS7+7NTDuJMd_DhJF6a4pw@mail.gmail.com>
 <852514139.11036267.1573172443439.JavaMail.zimbra@redhat.com>
 <20191111012614.GC6235@magnolia>
 <1751469294.11431533.1573460380206.JavaMail.zimbra@redhat.com>
 <20191111083815.GA29540@infradead.org>
Message-ID: <1757087132.11450258.1573468734360.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Is this a new test?

No, it's not new.

> If not why was this never reported?  Sounds like
> we should add this test case to xfstests.

I'm guessing not that many users still run 32bit kernels.
Naresh' setup is using ext4, so I assume he noticed only
after recent changes in linux-next wrt. directio and ext4.

Regards,
Jan


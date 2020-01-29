From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 29 Jan 2020 04:16:51 -0500 (EST)
Subject: [LTP] [PATCH 4.14 00/46] 4.14.169-stable review
In-Reply-To: <CA+G9fYsnSGw0NmV5hWwZSs5OYu18YRam3jYCsg4Sn+KUQJSMWw@mail.gmail.com>
References: <20200128135749.822297911@linuxfoundation.org>
 <CA+G9fYsnSGw0NmV5hWwZSs5OYu18YRam3jYCsg4Sn+KUQJSMWw@mail.gmail.com>
Message-ID: <1680515224.4725561.1580289411736.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> NOTE:
> LTP fs test read_all_proc fails intermittently on 4.9 and 4.14 branches.

[trim CC list to LTP]

Naresh, do you have some examples of these failures?
Has it started recently or do you see it long-term?
Is test timing out on some specific /proc entries?
If yes, is it possible to run test with strace or with "-v" so we can
see where it's getting stuck?

Thanks,
Jan


From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 18 Jun 2020 02:00:28 -0400 (EDT)
Subject: [LTP] [PATCH 3/3] syscalls/setns01: accept also EBADF for
 regular fd
In-Reply-To: <20200617151223.GB7370@yuki.lan>
References: <9b9e3d35b4fddb668b02595e418a997332f98491.1591347655.git.jstancek@redhat.com>
 <5632b2169cfe32807e8380be50ced5e5d6ff93cb.1591347655.git.jstancek@redhat.com>
 <20200617151223.GB7370@yuki.lan>
Message-ID: <607606933.16501449.1592460028318.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> And I guess that this is no longer needed, right?

If Christian's patch goes in then yes, we can drop this one.
I'll send v2 for 2/3.


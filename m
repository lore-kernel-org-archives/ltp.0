From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 21 Jun 2021 09:25:30 +0200
Subject: [LTP] [PATCH 2/2] shell: Extend timeout tests,
 to run on multiple shells
In-Reply-To: <2f8e652b-aaa8-5f98-4f9d-5b7c138c17fa@jv-coder.de>
References: <20210519063109.224352-1-lkml@jv-coder.de>
 <20210519063109.224352-2-lkml@jv-coder.de> <YKToUgBnK6ZQ5I0Q@yuki>
 <2f8e652b-aaa8-5f98-4f9d-5b7c138c17fa@jv-coder.de>
Message-ID: <YNA+6shWiWYRNi2P@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

I wonder what is the state of this patchset?
Do we still consider it?
Apart from reducing shells (i.e. which distro has ash, which is not
alias to other shell in the list) I'm not against non-default shells, but I
don't like how whole test gets complicated by this.

Also we're reinventing wheel with printing results, checking whether test exist
etc. Maybe using test API for this?

Kind regards,
Petr

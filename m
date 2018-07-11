From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 11 Jul 2018 04:54:38 -0400 (EDT)
Subject: [LTP] [PATCH] verify_caps_exec: Respect TMP environment variable
In-Reply-To: <20180622232353.151563-1-astrachan@google.com>
References: <20180622232353.151563-1-astrachan@google.com>
Message-ID: <93480014.31836255.1531299278505.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> The filecapstest.sh wrapper script already allows the /tmp directory to
> be overridden with the TMP environment variable, however doing so has
> no effect on verify_caps_exec because it creates its own version of this
> fifo at a hardcoded location under /tmp.
> 
> To ensure the fifo is correctly removed by the wrapper script, alter
> verify_caps_exec to respect the TMP environment variable and create a
> fifo at the same location.

Hi,

this doesn't seem to be enough, print_caps.c is also hardcoding /tmp.
Other than rewriting the test, I'm thinking simplest way to fix this is:

1. export FIFOFILE in wrapper script and then use that env. variable
in all *.c tests.

2. change wrapper script to use $TMPDIR if available
(that is the value exported by runltp)

What do you think?

Regards,
Jan

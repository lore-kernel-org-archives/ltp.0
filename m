From: Mark Brown <broonie@kernel.org>
Date: Mon, 3 Aug 2020 13:34:00 +0100
Subject: [LTP] [PATCH] selftests: vdso: hash entry size on alpha,
 s390x is 8 bytes
In-Reply-To: <1881588710.5797015.1596457102422.JavaMail.zimbra@redhat.com>
References: <9927ed18c642db002e43afe5e36fb9c18c4f9495.1594811090.git.jstancek@redhat.com>
 <1881588710.5797015.1596457102422.JavaMail.zimbra@redhat.com>
Message-ID: <20200803123400.GE4502@sirena.org.uk>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Aug 03, 2020 at 08:18:22AM -0400, Jan Stancek wrote:

> > Do similar check in parse_vdso.c and treat hash entries as double word.

> Ping, any thoughts about the issue or patch?

I'd suggest contacting the authors of that code.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200803/0fe44b87/attachment-0001.sig>

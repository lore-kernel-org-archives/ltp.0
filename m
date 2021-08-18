From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 18 Aug 2021 12:01:35 +0200
Subject: [LTP] [PATCH 3/3] commands: Drop which01.sh
In-Reply-To: <8589e81b-4c45-e62e-297a-ef6a3cd548dc@jv-coder.de>
References: <20210818091224.27578-1-pvorel@suse.cz>
 <20210818091224.27578-4-pvorel@suse.cz>
 <8589e81b-4c45-e62e-297a-ef6a3cd548dc@jv-coder.de>
Message-ID: <YRzaf3jq02zM306Y@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

> Hi Petr,

> On 8/18/2021 11:12 AM, Petr Vorel wrote:
> > "which" has been discontinued after 2.21 release in 2015 due this (git
> > repository is empty [1]).
> I am a bit against dropping this. which is widely used and I think as long
> as it is available, it should behave as expected.
First, thanks for your review of all patchset.

I should have marked this commit as RFC. I have no problem to postpone
deleting this test fairly long time (even for 1-2 years).

But, if we really want to test basic shell commands (IMHO they should be part of
particular shell implementation code and most of these projects have it: e.g.
bash, busybox, coreutils, util-linux, ...), in this particular test it'd be more
useful to test "type" or "command" than "which", which code hasn't been changed
since 2015. Looking into openSUSE code [1], there is no patch on "which"
command.

Also, I might be a bit too aggressive when removing tests for legacy code, but
in this case Debian has deprecated "which" from it's basic tools [2], proving
there is a push to use "type" / "command -v" at least in some distros.

Kind regards,
Petr

[1] https://build.opensuse.org/package/show/Base:System/which
[2] https://salsa.debian.org/debian/debianutils/-/commit/3a8dd10b4502f7bae8fc6973c13ce23fc9da7efb

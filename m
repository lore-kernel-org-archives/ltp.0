From: Steve Ellcey <sellcey@caviumnetworks.com>
Date: Wed, 08 Mar 2017 10:41:15 -0800
Subject: [LTP] Running LTP results in read-only filesystem
In-Reply-To: <20170308111930.GA28037@rei.lan>
References: <1488912047.22552.6.camel@caviumnetworks.com>
 <20170308111930.GA28037@rei.lan>
Message-ID: <1488998475.22552.12.camel@caviumnetworks.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

On Wed, 2017-03-08 at 12:19 +0100, Cyril Hrubis wrote:
> Hi!
> >=20
> > Has anyone run into a problem where running the LTP tests as root
> > results in a read-only filesystem? ??I have been running LTP as root on
> > an ubuntu 16.04 aarch64 system and it appears that when I do that my
> > root filesystem gets set to read-only and then, when I reboot to try
> > and fix the problem, the machine can't fsck itself and come back up
> > without some human intervention. ??Has anyone else seen this problem?
> I remember some FS journal corruptions on cheap SD cards being reported
> some time agoI remember some FS journal corruptions on cheap SD cards
> being reported some time ago. What filesystem do you use? Have you
> checked dmesg output, is there anything related there?

I am using an ext4 filesystem on a hard disk drive. =C2=A0dmesg is empty, it
may have gotten deleted during the reboot and/or the fsck that was done
during the reboot to get the system to come back up.

Steve Ellcey

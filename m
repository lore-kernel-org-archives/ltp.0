From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 18 Apr 2019 15:35:00 +0800
Subject: [LTP] LTP: mount02 was expected EINVAL(22) but got ENOENT(2):
 No such file or directory
In-Reply-To: <20190418072454.GD2217@ZenIV.linux.org.uk>
References: <CA+G9fYudJC07HfrU1fVptCEvgCuBsF9G2N76PiGG5Z258z0Dzg@mail.gmail.com>
 <226607771.7950393.1552490962324.JavaMail.zimbra@redhat.com>
 <CA+G9fYsDK=4jJ31qeTpOxif+j7dTijznsboMHRdkfhQ3V0+8tA@mail.gmail.com>
 <696858120.8161208.1552551805566.JavaMail.zimbra@redhat.com>
 <5CB823D9.8050902@cn.fujitsu.com> <20190418072454.GD2217@ZenIV.linux.org.uk>
Message-ID: <5CB828A4.5060305@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

On 2019/04/18 15:24, Al Viro wrote:
> On Thu, Apr 18, 2019 at 03:14:33PM +0800, Xiao Yang wrote:
>
>> Does you or Al Viro plan to replace ENOENT with ENOTBLK recently?
>> It seems that ENOENT still exists on v5.1-rc5.
> I am; I'm sorting the next pile of mount patches at the moment,
> and fix for that is going to be in the very beginning.
>
>
Hi Al=EF=BC=8C

Got it, thanks for your quick reply.

Best Regards,
Xiao Yang




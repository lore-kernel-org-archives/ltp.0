From: Eddie.Horng <eddie.horng@mediatek.com>
Date: Tue, 18 Sep 2018 10:18:48 +0800
Subject: [LTP] LTP master: arm64: execveat03: execveat() returned
 unexpected errno: EINVAL
In-Reply-To: <CA+G9fYuT3WKmA7Z1cKft4DCsR_oTX6JUjn_DGQXHk6j5KJYt2Q@mail.gmail.com>
References: <CA+G9fYsEqrXhTK=TJ0m8aTDonEG39HT1aLnV4GnsZuHB7c38ow@mail.gmail.com>
 <811224868.48837664.1537008641635.JavaMail.zimbra@redhat.com>
 <CABdQkv-nmBfK3=+2u2fHGCO-WVF=rHpnqVgHnxLechaL+VXyeA@mail.gmail.com>
 <CA+G9fYuT3WKmA7Z1cKft4DCsR_oTX6JUjn_DGQXHk6j5KJYt2Q@mail.gmail.com>
Message-ID: <1537237128.12499.5.camel@mtkswgap22>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, 2018-09-18 at 05:01 +0530, Naresh Kamboju wrote:
> >
> > Naresh,
> >
> > I would blacklist this one for 4.4 and 4.9.
> 
> LTP test case should detect old kernel versions and skip (CONF) it on
> older kernels instead of FAIL.
> 
> - Naresh

Hi Naresh,
The regression that execveat03 intends to test is introduced from 4.14, 
commit (8db6c34f1dbc Introduce v3 namespaced file capabilities).
So before 4.14 the case is expected to PASS, no required to skip it.

thanks,
Eddie



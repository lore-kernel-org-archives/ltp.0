From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 18 Sep 2018 05:01:41 +0530
Subject: [LTP] LTP master: arm64: execveat03: execveat() returned
 unexpected errno: EINVAL
In-Reply-To: <CABdQkv-nmBfK3=+2u2fHGCO-WVF=rHpnqVgHnxLechaL+VXyeA@mail.gmail.com>
References: <CA+G9fYsEqrXhTK=TJ0m8aTDonEG39HT1aLnV4GnsZuHB7c38ow@mail.gmail.com>
 <811224868.48837664.1537008641635.JavaMail.zimbra@redhat.com>
 <CABdQkv-nmBfK3=+2u2fHGCO-WVF=rHpnqVgHnxLechaL+VXyeA@mail.gmail.com>
Message-ID: <CA+G9fYuT3WKmA7Z1cKft4DCsR_oTX6JUjn_DGQXHk6j5KJYt2Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 16 September 2018 at 22:28, Rafael David Tinoco
<rafael.tinoco@linaro.org> wrote:
> Jan, Naresh:
>
> The fix has been backported to:
>
> $ git tag --contains ff1663fc9483e131f674db8b2f42f9a99460ae50
> v4.18.7
> v4.18.8
>
> $ git tag --contains 5a842ecca279f583c3fdc9a1ed8fe7a4cc348789
> v4.14.69
> v4.14.70
>
> This fix has not been backported to v4.9 nor v4.4.
>
> From the build URL:
> http://snapshots.linaro.org/openembedded/ltp/rocko/hikey/300/rpb/
> Looks like build from commit 94710cac did NOT contain needed fix.
>
> I think it will be all good for future builds.
>
> Naresh,
>
> I would blacklist this one for 4.4 and 4.9.

LTP test case should detect old kernel versions and skip (CONF) it on
older kernels instead of FAIL.

- Naresh

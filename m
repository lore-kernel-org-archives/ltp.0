From: Li Wang <liwang@redhat.com>
Date: Fri, 7 Dec 2018 14:28:32 +0800
Subject: [LTP] [PATCH 2/2] lib: build check parameters for tst_brk()
In-Reply-To: <20181206130736.GB31874@dell5510>
References: <88db8a4def940c63ec2836cec1d0041db00ffd4c.1541710635.git.jstancek@redhat.com>
 <d3ce5d3247f7f09cfabd288b40893bb631fb190f.1541710635.git.jstancek@redhat.com>
 <5BE4E95E.4000303@cn.fujitsu.com>
 <1582215982.71956713.1541786229415.JavaMail.zimbra@redhat.com>
 <20181204173542.GD30799@dell5510>
 <CAEemH2cD71UjUJ-b3HeTyf58JSUCcb+iCo9Om9Vez=L7UYwKmg@mail.gmail.com>
 <20181205092521.GA7618@dell5510>
 <CAEemH2f1xJnQV3dt_B1-coRgMRjggPXuHUPQLQq7fsTFkV9GMg@mail.gmail.com>
 <20181206130736.GB31874@dell5510>
Message-ID: <CAEemH2euo1jaG535wePDB76Z4x7+gfFBnRSsV9zfb-CgrFsYBA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On Thu, Dec 6, 2018 at 9:07 PM Petr Vorel <pvorel@suse.cz> wrote:

> > No, I saw kernel gives this limitation so just use it as that.
> > See: https://github.com/torvalds/linux/blob/master/include/linux/build_bug.h#L55
> OK, I didn't get from Jan's "There's an __attribute__(error), but it's supported
> only from gcc 4.3 as I recall.", that it is in 4.3 and older. First I thought
> it's a new feature, but didn't find any reference.

I have tried on Travis CI for many new commits build, I didn't found
GCC(even gcc-4.1.2) outthrow warning in the compiling phase. But seems
only clang(3.9, 4.0, 5.0) blames '__error__' is unknown attribute.
Maybe we should consider to check clang version, but currently I have
no idea which version should be set as baseline.

https://travis-ci.org/wangli5665/ltp/builds
https://github.com/wangli5665/ltp/blob/check-tst_brk-parameter/include/tst_common.h#L68

-- 
Regards,
Li Wang

From: Li Wang <liwang@redhat.com>
Date: Thu, 6 Dec 2018 18:15:53 +0800
Subject: [LTP] [PATCH 2/2] lib: build check parameters for tst_brk()
In-Reply-To: <5C08E9A4.1070604@cn.fujitsu.com>
References: <88db8a4def940c63ec2836cec1d0041db00ffd4c.1541710635.git.jstancek@redhat.com>
 <d3ce5d3247f7f09cfabd288b40893bb631fb190f.1541710635.git.jstancek@redhat.com>
 <5BE4E95E.4000303@cn.fujitsu.com>
 <1582215982.71956713.1541786229415.JavaMail.zimbra@redhat.com>
 <20181204173542.GD30799@dell5510>
 <CAEemH2cD71UjUJ-b3HeTyf58JSUCcb+iCo9Om9Vez=L7UYwKmg@mail.gmail.com>
 <20181205092521.GA7618@dell5510>
 <CAEemH2f1xJnQV3dt_B1-coRgMRjggPXuHUPQLQq7fsTFkV9GMg@mail.gmail.com>
 <5C08E9A4.1070604@cn.fujitsu.com>
Message-ID: <CAEemH2fRLDNmcq5AQtcR8nNacy42Kfd-K-XxjPDH=Fh2pYJrrA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:

> Perhaps, we need to distinguish between constants and variables by __builtin_constant_p().

Hmm, I don't think so. If someone pass 'TINFO/TPASS/TTYPO' via
variable, the tst_brk() parameter check will be missed there.

-- 
Regards,
Li Wang

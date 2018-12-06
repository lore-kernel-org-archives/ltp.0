From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 6 Dec 2018 13:59:05 +0100
Subject: [LTP] [PATCH 2/2] lib: build check parameters for tst_brk()
In-Reply-To: <CAEemH2cCL0O4Um6yBfpqH4sNxRE1fRLTzsDprDEODP1z+cQGXg@mail.gmail.com>
References: <88db8a4def940c63ec2836cec1d0041db00ffd4c.1541710635.git.jstancek@redhat.com>
 <d3ce5d3247f7f09cfabd288b40893bb631fb190f.1541710635.git.jstancek@redhat.com>
 <5BE4E95E.4000303@cn.fujitsu.com>
 <1582215982.71956713.1541786229415.JavaMail.zimbra@redhat.com>
 <20181204173542.GD30799@dell5510>
 <CAEemH2cD71UjUJ-b3HeTyf58JSUCcb+iCo9Om9Vez=L7UYwKmg@mail.gmail.com>
 <20181205092521.GA7618@dell5510>
 <CAEemH2f1xJnQV3dt_B1-coRgMRjggPXuHUPQLQq7fsTFkV9GMg@mail.gmail.com>
 <CAEemH2cCL0O4Um6yBfpqH4sNxRE1fRLTzsDprDEODP1z+cQGXg@mail.gmail.com>
Message-ID: <20181206125904.GA31874@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Li,

> Can you help to test this commit with same configuration in build#860?
> (I haven't mastered how to use Travis CI yet)
> https://github.com/wangli5665/ltp/commit/bbf236875c11861e40845edd875e517dd475bfac
Sure. This commit is on
https://travis-ci.org/pevik/ltp/builds/464316410
=> failing on
../../../../include/tst_common.h:72:35: error: call to ‘check_tst_brk_parameter_’ declared with attribute error: tst_brk(): invalid type, please use TBROK/TCONF/TFAIL

+ your branch check-tst_brk-parameter (with code cleanup commit)
https://github.com/wangli5665/ltp/commits/check-tst_brk-parameter
is on
https://travis-ci.org/pevik/ltp/builds/464316329
=> the same failure:
../../../../include/tst_common.h:72:35: warning: implicit declaration of function ‘check_tst_brk_parameter_’ [-Wimplicit-function-declaration]

Travis is not complicated: 1) register 2) give it rights to your account (I
don't like this) 3) enable ltp repository.
Every push since it it's triggered.

> I used gcc version 4.1.2 and didn't hit the un-supportted issue
> locally, I'm inclined to suspect there's no demands on gcc compiler.
The oldest gcc I have available is 4.3.

Kind regards,
Petr

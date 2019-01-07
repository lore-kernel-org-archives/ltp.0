From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 7 Jan 2019 19:25:14 +0100
Subject: [LTP] [PATCH 2/2] lib: build check parameters for tst_brk()
In-Reply-To: <124327317.93121782.1546516348350.JavaMail.zimbra@redhat.com>
References: <88db8a4def940c63ec2836cec1d0041db00ffd4c.1541710635.git.jstancek@redhat.com>
 <d3ce5d3247f7f09cfabd288b40893bb631fb190f.1541710635.git.jstancek@redhat.com>
 <5BE4E95E.4000303@cn.fujitsu.com>
 <1582215982.71956713.1541786229415.JavaMail.zimbra@redhat.com>
 <20181211145833.GB1180@rei>
 <124327317.93121782.1546516348350.JavaMail.zimbra@redhat.com>
Message-ID: <20190107182514.GD15221@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > We can always name the BUILD_BUG_ON() macro to be
> > TST_BRK_ONLY_SUPPORTS_TCONF_TBROK_TFAIL() and be done with it.
> > 
> > I would rather avoided playing with specific compiler features etc. So
> > this version looks good to me.
> 
> Pushed the original version for now.

FYI looks like we need to rename the BUILD_BUG_ON() after all:

gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W -Wold-style-definition  -Illtp -o quotactl03
In file included from ../../../../include/tst_test.h:29:0,
                 from quotactl03.c:53:
../../../../include/tst_common.h:68:0: warning: "BUILD_BUG_ON" redefined
 #define BUILD_BUG_ON(condition) \
 
In file included from /usr/include/xfs/xqm.h:21:0,
                 from quotactl03.c:50:
/usr/include/xfs/xfs.h:68:0: note: this is the location of the previous definiti
 #define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))
 
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W -Wold-style-definition  -Illtp -o quotactl01
In file included from quotactl01.c:56:0:
quotactl01.c: In function 'setup':
../../../../include/tst_test.h:85:3: warning: this statement may fall through [-
   tst_brk_(__FILE__, __LINE__, (ttype), (arg_fmt), ##__VA_ARGS__);\
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
quotactl01.c:169:3: note: in expansion of macro 'tst_brk'
   tst_brk(TCONF, "quotacheck binary not installed");
   ^~~~~~~
quotactl01.c:170:2: note: here
  default:
  ^~~~~~~


-- 
Cyril Hrubis
chrubis@suse.cz

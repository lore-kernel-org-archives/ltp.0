From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 3 Jan 2019 06:52:28 -0500 (EST)
Subject: [LTP] [PATCH 2/2] lib: build check parameters for tst_brk()
In-Reply-To: <20181211145833.GB1180@rei>
References: <88db8a4def940c63ec2836cec1d0041db00ffd4c.1541710635.git.jstancek@redhat.com>
 <d3ce5d3247f7f09cfabd288b40893bb631fb190f.1541710635.git.jstancek@redhat.com>
 <5BE4E95E.4000303@cn.fujitsu.com>
 <1582215982.71956713.1541786229415.JavaMail.zimbra@redhat.com>
 <20181211145833.GB1180@rei>
Message-ID: <124327317.93121782.1546516348350.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi!
> > Do you have suggestion how to achieve that?
> 
> We can always name the BUILD_BUG_ON() macro to be
> TST_BRK_ONLY_SUPPORTS_TCONF_TBROK_TFAIL() and be done with it.
> 
> I would rather avoided playing with specific compiler features etc. So
> this version looks good to me.

Pushed the original version for now.

Regards,
Jan

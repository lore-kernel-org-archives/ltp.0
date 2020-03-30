From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 30 Mar 2020 22:29:15 +0200
Subject: [LTP] [PATCH v2 5/5] Use SAFE_CMD()
In-Reply-To: <20200330200250.GB8636@dell5510>
References: <20200330124338.6764-1-pvorel@suse.cz>
 <20200330124338.6764-6-pvorel@suse.cz>
 <CAEemH2dQfpn9mEBY=CFfVj_8dLETD7zh4=j3KP-bt95m_CCBxg@mail.gmail.com>
 <20200330200250.GB8636@dell5510>
Message-ID: <20200330202915.GB6505@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

...
> + I needed to put back static inline for safe_cmd() (it was in previous version,
> it's really needed). So there is latest version available on
> https://github.com/pevik/ltp/tree/needs_cmds.v2.fixes

> which passed some travis jobs (I'll check that tomorrow)
> https://travis-ci.org/github/pevik/ltp/builds/668925599
Working. Just opensuse/tumbleweed fails, but that's due bug in the distro
(it also broke CI on master, I'll report it tomorrow).

Kind regards,
Petr

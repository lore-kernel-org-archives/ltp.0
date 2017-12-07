From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 7 Dec 2017 13:18:19 +0100
Subject: [LTP] [RFC PATCH 1/2] network/ipsec: Add trap to INT and
	require root
In-Reply-To: <91d018e3-744f-ec0d-114a-05871d3a1205@oracle.com>
References: <20171206144214.27317-1-pvorel@suse.cz>
 <91d018e3-744f-ec0d-114a-05871d3a1205@oracle.com>
Message-ID: <20171207121819.rojckr2gxgwng2aj@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Alexey,

> > +trap "tst_brkm TBROK 'test interrupted'" INT

> Could we add it to test_net.sh?
Sure. I was even thinking about giving it into test_net.sh and test.sh (i.e. making it the
default settings), but that's maybe too aggressive.


> $ grep 'trap "' . -r

> ./busy_poll/busy_poll03.sh:trap "tst_brkm TBROK 'test interrupted'" INT
> ./busy_poll/busy_poll01.sh:trap "tst_brkm TBROK 'test interrupted'" INT
> ./busy_poll/busy_poll02.sh:trap "tst_brkm TBROK 'test interrupted'" INT
> ./stress/ns-tools/test_net_stress.sh:   trap "tst_brkm TBROK 'test interrupted'" INT
> ./stress/ssh/ssh-stress:        trap "tst_brkm TBROK 'test interrupted'" INT
> ./stress/ftp/ftp-upload-stress: trap "tst_brkm TBROK 'test interrupted'" INT
> ./stress/ftp/ftp-download-stress:       trap "tst_brkm TBROK 'test interrupted'" INT
> ./stress/interface/if4-addr-change:trap "tst_brkm TBROK 'test interrupted'" INT
> ./stress/http/http-stress:      trap "tst_brkm TBROK 'test interrupted'" INT
> ./stress/dns/dns-stress:        trap "tst_brkm TBROK 'test interrupted'" INT
> ./dhcp/dhcp_lib.sh:trap "tst_brkm TBROK 'test interrupted'" INT
> ./virt/virt_lib.sh:trap "tst_brkm TBROK 'test interrupted'" INT
> ./tcp_fastopen/tcp_fastopen_run.sh:trap "tst_brkm TBROK 'test interrupted'" INT


Kind regards,
Petr

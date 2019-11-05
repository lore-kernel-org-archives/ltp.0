From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 5 Nov 2019 09:46:37 +0100
Subject: [LTP] [PATCH 1/1] Fix compression ratio calculation in zram01
In-Reply-To: <20191105082322.GA16218@dell5510>
References: <20191104125228.17173-1-mdoucha@suse.cz>
 <20191104125228.17173-2-mdoucha@suse.cz> <20191104151647.GA15477@dell5510>
 <7c68a69d-8edd-d4d5-de1d-39d2cb8e4f03@suse.cz>
 <20191105082322.GA16218@dell5510>
Message-ID: <7e21cd7d-19f3-d65d-b968-5969cf7c34d3@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11/5/19 9:23 AM, Petr Vorel wrote:
> Do you mean that dd filling zram could find a regression?
> 
> I'm asking because it's a bit strange to have test,
> which doesn't lead to any result (TPASS/TFAIL/TBROK/TCONF), which will be
> 
> If this part is also a test, maybe following TINFO should be changed to TPASS.
> + Also new shell API allows to use loop in API (code simplify), but that
> requires for each run to produce a result.

Note the TBROK if `dd` fails to write anything at all. But I'll change
the TINFO to TPASS and resubmit.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

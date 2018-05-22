From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 22 May 2018 21:49:57 +0200
Subject: [LTP] [PATCH v3 1/1] ipneigh : Use new API
In-Reply-To: <7e8ad415-d92b-0911-1018-dbd1f3137912@suse.de>
References: <20180517090711.10577-1-asmorodskyi@suse.com>
 <20180517170918.qj2svkrqlbftmfjd@dell5510>
 <7e8ad415-d92b-0911-1018-dbd1f3137912@suse.de>
Message-ID: <20180522194957.criagw3qgwgdgrli@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Anton,

> > You can provide your own file with tests cases you want, put that file in /opt/ltp/runtest/
> > $ cat /opt/ltp/runtest/test
> > ipneigh6_ip ipneigh01.sh -6 -c ip
> > ipneigh01_arp ipneigh01.sh -c arp
> > ipneigh01_ip ipneigh01.sh -c ip

> > $ PASSWD=your-root-password /opt/ltp/testscripts/network.sh -f test
> thanks for advice , I also thought about something like this because I think
> that ipneigh term is not the best one and not showing what actually covered
> ( not only ip neighbour but also arp command ) and both cases it is just
> tools to
> delete line from arp table which is just one step in test flow and not sure
> if it is main one ? But I don't feel confident enough to came up with new
> name. And I would do what you suggesting here only if I will have better
> name for ipneigh01.sh script. Do you have some certain ideas how better to
> name it ?

Command was renamed in a217233ab:
network/tcp_cmds/arp01: rename to ipneigh01

    'ipneigh' is more appropriate name for the test as it covers
    IPv4 and IPv6 cache entries with 'ip neigh' command and arp
    command is obsolete.
---
I think that's valid point, I'd keep the name. One day arp part gets deleted.

> > > -	tst_resm TINFO "Stress auto-creation of $entry_name cache entry"
> > > -	tst_resm TINFO "by pinging '$rhost' and deleting entry again"
> > > -	tst_resm TINFO "with '$arp_del_cmd'"
> > > +	tst_res TINFO "Stress auto-creation of $entry_name cache entry"
> > > +	tst_res TINFO "by pinging '$rhost'"
> > > +	tst_res TINFO "and deleting entry again with '$del_cmd'"
> > > +	tst_res TINFO "in a loop with $NUMLOOPS iterations"
> > Probably this would be enough:
> > 	tst_res TINFO "Stress auto-creation of $entry_name cache entry $NUMLOOPS times"
> Why you think that 4 lines is too much ? I personally don't see a problem to
> give user a little more info and don't think that you can call it spaming
I really thing that this is sufficient enough (I forgot to add the command before):
  	tst_res TINFO "Stress auto-creation of $entry_name cache entry with '$del_cmd' $NUMLOOPS times"
Why shorter lines:
1) This 4 lines is trying to express what the test does. Curious user
should look into the test itself. LTP approach is to print command when they fail,
otherwise be informative, but not verbose.
2) It's difficult to grep log message which is split, it's better to avoid it if possible)


Kind regards,
Petr

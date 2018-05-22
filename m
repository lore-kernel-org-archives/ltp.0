From: Anton Smorodskyi <asmorodskyi@suse.de>
Date: Tue, 22 May 2018 13:49:32 +0200
Subject: [LTP] [PATCH v3 1/1] ipneigh : Use new API
In-Reply-To: <20180517170918.qj2svkrqlbftmfjd@dell5510>
References: <20180517090711.10577-1-asmorodskyi@suse.com>
 <20180517170918.qj2svkrqlbftmfjd@dell5510>
Message-ID: <7e8ad415-d92b-0911-1018-dbd1f3137912@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Petr


> You can provide your own file with tests cases you want, put that file in /opt/ltp/runtest/
> $ cat /opt/ltp/runtest/test
> ipneigh6_ip ipneigh01.sh -6 -c ip
> ipneigh01_arp ipneigh01.sh -c arp
> ipneigh01_ip ipneigh01.sh -c ip
>
> $ PASSWD=your-root-password /opt/ltp/testscripts/network.sh -f test
thanks for advice , I also thought about something like this because I 
think that ipneigh term is not the best one and not showing what 
actually covered ( not only ip neighbour but also arp command ) and both 
cases it is just tools to
delete line from arp table which is just one step in test flow and not 
sure if it is main one ? But I don't feel confident enough to came up 
with new name. And I would do what you suggesting here only if I will 
have better name for ipneigh01.sh script. Do you have some certain ideas 
how better to name it ?
>
>> -	tst_resm TINFO "Stress auto-creation of $entry_name cache entry"
>> -	tst_resm TINFO "by pinging '$rhost' and deleting entry again"
>> -	tst_resm TINFO "with '$arp_del_cmd'"
>> +	tst_res TINFO "Stress auto-creation of $entry_name cache entry"
>> +	tst_res TINFO "by pinging '$rhost'"
>> +	tst_res TINFO "and deleting entry again with '$del_cmd'"
>> +	tst_res TINFO "in a loop with $NUMLOOPS iterations"
> Probably this would be enough:
> 	tst_res TINFO "Stress auto-creation of $entry_name cache entry $NUMLOOPS times"
Why you think that 4 lines is too much ? I personally don't see a 
problem to give user a little more info and don't think that you can 
call it spaming


.............

all other your suggestions are applied . after solving this two topics I 
will provide v4 ( hope the last one :D )

-- 
Anton Smorodskyi <asmorodskyi@suse.com>
QA Engineer
SUSE Linux GmbH, Maxfeldstr. 5, D-90409 Nürnberg
Tel: +49-911-74053-0; Fax: +49-911-7417755;  https://www.suse.com/
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard,
Graham Norton, HRB 21284 (AG Nürnberg)

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180522/a291d0e6/attachment.html>

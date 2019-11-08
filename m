From: Martin Doucha <mdoucha@suse.cz>
Date: Fri, 8 Nov 2019 16:31:29 +0100
Subject: [LTP] [PATCH v2 1/1] Fix compression ratio calculation in zram01
In-Reply-To: <20191108152902.GA8931@rei>
References: <20191105082322.GA16218@dell5510>
 <20191105090339.6522-1-mdoucha@suse.cz>
 <20191105090339.6522-2-mdoucha@suse.cz> <20191108152902.GA8931@rei>
Message-ID: <9be265bd-109b-6123-98e7-e055e0b3ec89@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11/8/19 4:29 PM, Cyril Hrubis wrote:
> Hi!
>> +		local compr_size=`cat "/sys/block/zram$i/mm_stat" | awk '{print $2}'`
> 
> Why not just:
> 
> 	awk '{print $2}' /sys/block/zram$i/mm_stat
> 
> Other than this it looks good. Also no need to send v3, I can fix this
> when applying.

You're right, please fix it.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

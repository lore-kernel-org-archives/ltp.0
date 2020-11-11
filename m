From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 11 Nov 2020 18:01:51 +0300
Subject: [LTP] [PATCH v4] tcp_cmds/ping/ping02: Make it compatible with
 Busybox
In-Reply-To: <20201111144005.GA3358@pevik>
References: <20201110180533.28595-1-kory.maincent@bootlin.com>
 <20201111144005.GA3358@pevik>
Message-ID: <5fab0669-9597-8e20-4f6b-3c21da0e125c@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11.11.2020 17:40, Petr Vorel wrote:
> Hi Kory, Alexey,
> 
>> The ping from busybox does not have -f parameter, use -i parameter instead.
>> BusyBox does not accept pattern longer than 2 bytes.
>> BusyBox support -i option since version 1.30
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Tested-by: Petr Vorel <pvorel@suse.cz>
> 
> LGTM.
> 
> I suggest to merge with few changes below.
> 
> * more precise message "ping from old busybox?"
> * use just $(tst_ipaddr rhost) instead of $ipaddr
> (some time ago we've started to use function calls for these simple evaluations)
> * upper case for global variable (ugly, but easily recognizable

Hi Petr,

Feel free to add the style changes, ack. I've already applied the patch.

Thanks Kory!


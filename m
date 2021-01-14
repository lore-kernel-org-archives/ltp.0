From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 14 Jan 2021 18:36:03 +0300
Subject: [LTP] [PATCH 1/1] if-mtu-change.sh: Lower CHANGE_INTERVAL to 1
In-Reply-To: <YABZkHIQmDUnKFZF@pevik>
References: <20210107120247.31465-1-pvorel@suse.cz>
 <d7eba485-08db-1cc7-abe6-38d23c244bfb@oracle.com> <X/7+vk6WsJ2LDJlC@pevik>
 <dced71df-28f6-056e-9518-338cccce4c11@oracle.com> <YABZkHIQmDUnKFZF@pevik>
Message-ID: <95ee938f-e045-4564-f6b2-952d54d2505b@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 14.01.2021 17:47, Petr Vorel wrote:
> Hi Alexey,
> 
>> Hi Petr,
> 
>> Do you mean "sleep $NS_DURATION" in mcast-pktfld02.sh is not needed
> Yes: sleep $NS_DURATION in mcast-pktfld02.sh and other mcast*.sh tests in:
> https://urldefense.com/v3/__https://patchwork.ozlabs.org/project/ltp/patch/20201125053459.3314021-2-lkml@jv-coder.de/__;!!GqivPVa7Brio!P0xbdqXlRQX7GPsKJmcPapdEOX5VV4OnkCKv-P9OqIWNcTvY9a9KXhOSjdJ1dKco5YbG$ 
> https://urldefense.com/v3/__https://patchwork.ozlabs.org/project/ltp/patch/20201125053459.3314021-1-lkml@jv-coder.de/__;!!GqivPVa7Brio!P0xbdqXlRQX7GPsKJmcPapdEOX5VV4OnkCKv-P9OqIWNcTvY9a9KXhOSjdJ1dKjzIVpO$ 
> 

It's needed because the commands run in parallel in the background
during $NS_DURATION. Without it, the test terminates them all shortly
after starting.

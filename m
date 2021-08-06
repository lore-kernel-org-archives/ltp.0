From: Joerg Vehlow <lkml@jv-coder.de>
Date: Fri, 6 Aug 2021 11:21:05 +0200
Subject: [LTP] [PATCH v1] connectors/cn_pec: improve reliability
In-Reply-To: <VI1PR04MB4958D95FE7A478B771C73A4493F39@VI1PR04MB4958.eurprd04.prod.outlook.com>
References: <20210805140806.3884-1-bogdan.lezhepekov@suse.com>
 <YQzpXHDvFmoaSFhi@pevik> <bb73135b-4ee3-71c3-5442-bf39064b3534@jv-coder.de>
 <VI1PR04MB4958D95FE7A478B771C73A4493F39@VI1PR04MB4958.eurprd04.prod.outlook.com>
Message-ID: <d2f9c8df-96bb-c115-6c2c-f3d8eb02c62b@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Bogdan,

On 8/6/2021 11:06 AM, Bogdan Lezhepekov wrote:
> Hi Joerg, Petr!
>
> Thanks for reviewing and commenting! I don't have a strong opinion on 
> how the test flow should look like, but I can say this sleep 
> definitely makes the test much more reliable.
>
> The results, we get on known to both of you SUSE Carwos, are pretty 
> consistent. My feeling is that 8/10 runs end up with some sporadic 
> failures. The fact that extra sleep solves the problem obviously 
> indicates a lack of synchronization.
>
> @Joerg: if you need more info about the environment, please reach out 
> to me.
Strange, my test environment was probably something derived from carwos 
(not exactly sure anymore).
I will try to reproduce and implement a correct synchronization as 
described in my earlier mail next week.
But maybe you can tell me more details about the actual used environment 
(If it is related to carwos customer project, you can send it to my 
corporate email address: joerg.vehlow@aox-tech.de).

Joerg

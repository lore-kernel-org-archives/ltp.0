From: Joerg Vehlow <lkml@jv-coder.de>
Date: Fri, 6 Aug 2021 06:35:47 +0200
Subject: [LTP] [PATCH v1] connectors/cn_pec: improve reliability
In-Reply-To: <20210805140806.3884-1-bogdan.lezhepekov@suse.com>
References: <20210805140806.3884-1-bogdan.lezhepekov@suse.com>
Message-ID: <eedb05a1-9e21-4047-3669-26f9012d942d@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On 8/5/2021 4:08 PM, Bogdan Lezhepekov via ltp wrote:
> Sometimes pec_listener has not enough time to handle all
> the generated events.
>
> This patch only returns back the delay that was removed
> in a recent patch.
I think I thought about keeping or removing this delay and finally 
decided to remove it for some reason, that I do not remember right now.
Can you tell me the environment where this failed?

Joerg

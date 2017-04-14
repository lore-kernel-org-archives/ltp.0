From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 14 Apr 2017 14:16:06 +0200
Subject: [LTP] [RFC PATCH v4 0/3] Simplify network setup
In-Reply-To: <3e5e2cda-38f3-b951-2186-46f50740a0ee@oracle.com>
References: <20170405204418.3240-1-pvorel@suse.cz>
 <5d196274-519f-fb5c-f971-29ece892330d@oracle.com>
 <20170414091222.ahrdtbid4pydsm2o@x230>
 <20170414091742.px3y4evyg7sl6rcy@x230>
 <3e5e2cda-38f3-b951-2186-46f50740a0ee@oracle.com>
Message-ID: <20170414121606.ikzkbcfamomu3fde@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Used default options for gcc in OL6, I guess in my case it has --std=gnu89
> by default and you have something different, may be gnu99...
Right! Wouldn't it be better to have it explicitly set as default in
include/mk/config.mk.default? I'm going to send RFC patch about it.


Kind regards,
Petr

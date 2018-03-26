From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 26 Mar 2018 14:42:00 +0200
Subject: [LTP] [PATCH] setregid: use common user and group names.
In-Reply-To: <20180319200113.106692-1-sspatil@google.com>
References: <20180319200113.106692-1-sspatil@google.com>
Message-ID: <20180326124200.GA311@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Sandeep,

> Android systems do not have groups names 'users' 'sys' etc. Replace them
> with 'nobody' and 'daemon' for the purposes of setregid0[34] tests and
> make the nomenclature across both of these tests more consistent.

> After the change, both setregid03 and setregid04 can run
> on Android systems.
I guess we don't care about older-but-still-quite-new releases and look for the future (as
'daemon' was added to aosp quite recently, 'shell' would also work for older).

[1] https://android.googlesource.com/platform/system%2Fcore/+/8e8648463d74005ac3111235b6bdea9c79d7a34a

Kind regards,
Petr

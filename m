From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 1 Oct 2018 14:42:27 +0200
Subject: [LTP] [PATCH] device-drivers/acpi: skip certain tests for
 HW-reduced ACPI
In-Reply-To: <d10e9ad6-0b17-bac4-8f8b-09e8ad5be09a@oracle.com>
References: <1534520593-14253-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <d10e9ad6-0b17-bac4-8f8b-09e8ad5be09a@oracle.com>
Message-ID: <20181001124227.GB27555@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Could anybody have a look at this, please?

Looks OK, I haven't checked the ACPI calls used to get the reduced flag
are correct though.

-- 
Cyril Hrubis
chrubis@suse.cz

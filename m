From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 28 May 2020 13:40:54 +0200
Subject: [LTP] [RFC PATCH 0/2] LVM: Drop legacy scripts and runtest files
In-Reply-To: <20200528110554.10179-1-pvorel@suse.cz>
References: <20200528110554.10179-1-pvorel@suse.cz>
Message-ID: <20200528114054.GA16726@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

growfiles are used also in other runtest files: fs, fs_readonly, scsi_debug.part1.
I wonder how to reduce duplicity for fs and fs_readonly.

runtest/scsi_debug.part1 should be IMHO deleted. And
testscripts/ltp-scsi_debug.sh should be either deleted, or, if the idea is
valid (using scsi_debug kernel module for testing), it should be rewritten.

Other candidate for deleting are ltpfs tests (testcases/kernel/fs/scsi/ltpfs/).
They're not maintained, ltpfsio.sh and ltpfstest is not even installed.

Kind regards,
Petr

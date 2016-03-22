From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 22 Mar 2016 15:44:40 +0100
Subject: [LTP] poll02 threshold overruns
In-Reply-To: <SN1PR12MB07827F3598E13F4E6F9E9401EE800@SN1PR12MB0782.namprd12.prod.outlook.com>
References: <SN1PR12MB07827ABE2B50365F2C528A03EE8F0@SN1PR12MB0782.namprd12.prod.outlook.com>
 <20160322092735.GA9410@rei.lan>
 <SN1PR12MB07827F3598E13F4E6F9E9401EE800@SN1PR12MB0782.namprd12.prod.outlook.com>
Message-ID: <20160322144440.GF10905@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> What kernel configurations are we talking about here?

I'm afraid that there is quite a lot, starting at scheduller choice,
support for hardware hrtimers or CONFIG_HZ, etc. I'm not expert on
kernel timers to make an exhaustive list.

> Is there a formula to calculate threshold based on CPU speed and kernel parameters?

I doubt that there is one. The problem is quite complex and the result
wouldn't be worth of the work.

-- 
Cyril Hrubis
chrubis@suse.cz

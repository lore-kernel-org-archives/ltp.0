From: Kshitij Malik <Kshitij.Malik@mitel.com>
Date: Tue, 22 Mar 2016 15:26:37 +0000
Subject: [LTP] poll02 threshold overruns
In-Reply-To: <20160322144440.GF10905@rei.suse.cz>
References: <SN1PR12MB07827ABE2B50365F2C528A03EE8F0@SN1PR12MB0782.namprd12.prod.outlook.com>
 <20160322092735.GA9410@rei.lan>
 <SN1PR12MB07827F3598E13F4E6F9E9401EE800@SN1PR12MB0782.namprd12.prod.outlook.com>,
 <20160322144440.GF10905@rei.suse.cz>
Message-ID: <SN1PR12MB07822C880E443435F77C5821EE800@SN1PR12MB0782.namprd12.prod.outlook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Thank you Cyril for the clarification.

I understand what you mean. I guess I just have to ignore this particular test for our platform. We know polling works as poll01 test passes without any issue and hence it is not an issue with our BSP or kernel.

Thank you for your support.

KK
________________________________________
From: Cyril Hrubis <chrubis@suse.cz>
Sent: Tuesday, March 22, 2016 10:44
To: Kshitij Malik
Cc: ltp@lists.linux.it
Subject: Re: poll02 threshold overruns

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
________________________________
NOTE: This e-mail (including any attachments) is for the sole use of the intended recipient(s) and may contain information that is confidential and/or protected by legal privilege. Any unauthorized review, use, copy, disclosure or distribution of this e-mail is strictly prohibited. If you are not the intended recipient, please notify Mitel immediately and destroy all copies of this e-mail. Mitel does not accept any liability for breach of security, error or virus that may result from the transmission of this message.
